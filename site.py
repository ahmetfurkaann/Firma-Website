from re import U
from sys import unraisablehook
from flask import Flask, g,render_template,flash,redirect,url_for,session,logging,request
from flask_mysqldb import MySQL
from wtforms import Form,StringField,TextAreaField,PasswordField,validators
from passlib.hash import sha256_crypt
from functools import wraps

# Kullanıcı Giriş Decorator
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:
            return f(*args, **kwargs)
        else:
            flash("Bu sayfayı görüntülemek için lütfen giriş yapın.","danger")
            return redirect(url_for("forbidden"))           # YETKİSİZ ERİŞİMDE TEKRARDAN LOGIN SAYFASINA YÖNLENDİRİLİYORUZ
    return decorated_function


app = Flask(__name__)
app.secret_key = "ahmetfurkandb"
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "ahmet_furkan_db"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)


# Kontrol Paneli
@app.route("/dashboard")
@login_required
def dashboard():
    return render_template("dashboard.html")

@app.errorhandler(404)
def page_not_found(error):
    return render_template('404notfound.html'), 404

@app.route("/403forbidden")
def forbidden():
    return render_template("403forbidden.html")



# Logout İşlemi
@app.route("/logout")
def logout():
    session.clear()                         # SESSION TEMİZLEMEYİ MUTLAKA YAP UNUTMA SAKIN
    return redirect(url_for("index"))

# Index 
@app.route("/")
def index():
    cursor = mysql.connection.cursor()
    cursor2 = mysql.connection.cursor()
    elemansayisi = "Select * From eleman"
    koronasayisi = "select DISTINCT tc_no from covid"
    result = cursor.execute(elemansayisi)
    result2 = cursor2.execute(koronasayisi)
    if result or result2 > 0:
        data = cursor.fetchall()
        data2 = cursor2.fetchall()
        eleman_sayisi = len(data)
        korona_sayisi = len(data2)
        return render_template("index.html",eleman_sayisi = eleman_sayisi,korona_sayisi=korona_sayisi)
    else:
        return render_template("index.html")


# Kayıt Olma
@app.route("/register",methods = ["GET", "POST"])
@login_required
def register():
    if request.method == "POST":          # KAYIT OLMA GİBİ BİR VERİ YOLLAMAYA POST REQUEST DENİR
        name = request.form.get('name')
        email = request.form.get('eposta')
        username = request.form.get('username')
        password = sha256_crypt.encrypt(request.form.get('password'))
        
        cursor = mysql.connection.cursor()
        sorgu = "Insert into users(name,email,username,password) VALUES(%s,%s,%s,%s)"

        cursor.execute(sorgu,(name,email,username,password))
          
        mysql.connection.commit()
        cursor.close()
        flash("Başarılı bir şekilde kayıt oldunuz","success")
        return redirect(url_for("login"))                   # LOGİN FONKSİYONUNA İLİŞKİN URL ADRESE GİTTİK
    else:                                                   # SUNUCUDAN BİR VERİ İSTERSSEK DE BUNA GET REQUEST DENİR
        return render_template("register.html")

# Login İşlemi
@app.route("/login",methods = ["GET","POST"])
def login():
    if request.method == "POST":
        username = request.form.get('username')
        password_entered= request.form.get('password')

        cursor = mysql.connection.cursor()                  # MYSQL DE DOLAŞMAYI SAĞLIYOR

        sorgu = "Select * From users where username = %s"
        result = cursor.execute(sorgu,(username,))          # BUNU DEMET OLARAK VERMEN GEREKTİĞİ İÇİN usernamedeen sonra virgül(,) gelmelidir.
        
        if result > 0:
            data = cursor.fetchone()                    # KULLANICININ TÜM VERİLERİNİ ALMIŞ BULUNMAKTAYIZ. (NAME, USERNAME, PASSWORD, EMAIL)    
            real_password = data["password"]            # ŞİFRELENMİŞ ŞİFRE
            if(sha256_crypt.verify(password_entered,real_password)):
                flash("Başarılı bir şekilde giriş yaptınız.","success")
                session["logged_in"] = True
                session["username"] = username
                return redirect(url_for("index"))
            else:
                flash("Parolayı yanlış girdiniz","danger")
                return redirect(url_for("login"))
        else:
            flash("Böyle bir kullanıcı bulunmuyor...","danger")
            return redirect(url_for("login"))
    return render_template("login.html")



# Çalışan Ekleme
@app.route("/veri/1",methods = ["GET","POST"])
@login_required
def istatistik1():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        isim = request.form.get('isim')
        soyisim = request.form.get('soyisim')
        kangrubu = request.form.get('kangrubu')
        sehir = request.form.get('sehir')
        pozisyon = request.form.get('pozisyon')
        maas = request.form.get('maas')
        lisans = request.form.get('lisans')
        yukseklisans = request.form.get('yukseklisans')
        doktora = request.form.get('doktora')
        asidurumu = request.form.get('asidurumu')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into eleman(tc_no,isim,soyisim,kan_grubu,dogum_yeri,pozisyon,maas,lisans,yuksek_lisans,doktora,asi_id) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(sorgu,(tcno,isim,soyisim,kangrubu,sehir,pozisyon,maas,lisans,yukseklisans,doktora,asidurumu))

        mysql.connection.commit()
        cursor.close()
        flash("Çalışan başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik1"))
    else:
        return render_template("veri1.html")



# Çalışan Silme ve güncelleme
@app.route("/veri/2")
@login_required
def istatistik2():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From eleman order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        elemanlar = cursor.fetchall()
        return render_template("veri2.html",elemanlar = elemanlar)
    else:
        return render_template("veri2.html")
    

@app.route("/veri/2/delete/<string:id>")
@login_required
def delete(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from eleman where eleman_id = %s"
    result = cursor.execute(sorgu,(id,))

    if result > 0:
        sorgu2 = "Delete from eleman where eleman_id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik2"))
    else:
        flash("Bu numaralı id'de eleman bulunmamaktadır.")
        return redirect(url_for("index"))


# VERİ/2/EDIT/X TARAFINDA VERİ ÇEKİLİYOR VE ORADAN VERİ3.HTML'DEKİ TABLOYA VERİLER GÖNDERİLİYOR. YANI
# VERİ3.HTML LAZIM. SAKIN SİİİLLLMEEEE
@app.route("/veri/2/edit/<string:id>",methods=["GET","POST"])
@login_required
def edit(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM eleman WHERE eleman_id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        return render_template('veri3.html',employee=data[0])
    else:
        newtcno = request.form['tcno']
        newisim = request.form['isim']
        newsoyisim = request.form['soyisim']
        newkangrubu = request.form['kangrubu']
        newdogumyeri = request.form['sehir']
        newpozisyon = request.form['pozisyon']
        newmaas = request.form['maas']
        newlisans = request.form['lisans']
        newyukseklisans = request.form['yukseklisans']
        newdoktora = request.form['doktora']
        newasidurumu = request.form['asidurumu']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE eleman SET tc_no = %s, isim = %s, soyisim = %s, kan_grubu = %s, dogum_yeri = %s, pozisyon = %s, maas = %s, lisans = %s, yuksek_lisans = %s,doktora = %s,asi_id = %s WHERE eleman_id = %s"
        result = cursor.execute(sorgu,(newtcno,newisim,newsoyisim,newkangrubu,newdogumyeri,newpozisyon,newmaas,newlisans,newyukseklisans,newdoktora,newasidurumu,id))
        mysql.connection.commit()
        if result > 0:
            flash("Çalışan başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik2"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik2"))





# HASTALIK EKLEME
@app.route("/veri/4",methods=["GET", "POST"])
@login_required
def istatistik4():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        hastalikadi = request.form.get('hastalikadi')
        hastaliktarihi = request.form.get('hastaliktarihi')
        hastaliktarihiTrue = hastaliktarihi.replace(".", "-") #Hastalık tarihi DD.MM.YYYY şeklinde geliyor. Bunu DD-MM-YYYY şekline çeviriyor
        ilac = request.form.get('ilac')
        doz = request.form.get('doz')
        semptom = request.form.get('semptom')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into hasta(tc_no,hastalik_adi,hastalik_tarihi,ilac,doz,semptomlar) VALUES(%s,%s,%s,%s,%s,%s)"
        cursor.execute(sorgu,(tcno,hastalikadi,hastaliktarihiTrue,ilac,doz,semptom))
        mysql.connection.commit()
        cursor.close()
        flash("Çalışanın hastalığı başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik4"))
    else:
        return render_template("veri4.html")



# Hastalık görüntüleme tablosu, silme ve güncelleme
# HASTALIK SİLME ÇALIŞIYOR
@app.route("/veri/5")
@login_required
def istatistik5():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From hasta order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        hastalik = cursor.fetchall()
        return render_template("veri5.html",hastalik = hastalik)
    else:
        return render_template("veri5.html")


@app.route("/veri/5/delete/<string:id>")
@login_required
def hastaliksil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from hasta where id = %s"
    result = cursor.execute(sorgu,(id,))

    if result > 0:
        sorgu2 = "Delete from hasta where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik4"))
    else:
        flash("Bu numaralı id'de hastalık bulunmamaktadır.")
        return redirect(url_for("index"))


@app.route("/veri/5/edit/<string:id>",methods=["GET","POST"])
@login_required
def hastalikduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM hasta WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        print(data[0])
        return render_template('veri6.html',hasta=data[0])
    else:
        newtcno = request.form['tcno']
        newhastalikadi = request.form['hastalikadi']
        newhastaliktarihi = request.form['hastaliktarihi']
        newilac = request.form['ilac']
        newdoz = request.form['doz']
        newsemptom = request.form.get("semptomlar")
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE hasta SET tc_no = %s, hastalik_adi = %s, hastalik_tarihi = %s, ilac = %s, doz = %s, semptomlar = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newhastalikadi,newhastaliktarihi,newilac,newdoz,newsemptom,id))
        mysql.connection.commit()
        if result > 0:
            flash("Hastalık başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik5"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik5"))






# COVID BİLGİSİ EKLEME
@app.route("/veri/7",methods=["GET", "POST"])
@login_required
def istatistik7():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        yakalandigitarih = request.form.get('yakalandigitarih')
        negatiftarih = request.form.get('negatiftarih')
        yakalandigitarihTrue = yakalandigitarih.replace(".", "-") #Hastalık tarihi DD.MM.YYYY şeklinde geliyor. Bunu DD-MM-YYYY şekline çeviriyor
        negatiftarihTrue = negatiftarih.replace(".", "-") #Hastalık tarihi DD.MM.YYYY şeklinde geliyor. Bunu DD-MM-YYYY şekline çeviriyor
        asidurumu = request.form.get('asidurumu')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into covid(tc_no,yakalandigi_tarih,negatif_tarihi,asi_id) VALUES(%s,%s,%s,%s)"
        cursor.execute(sorgu,(tcno,yakalandigitarihTrue,negatiftarihTrue,asidurumu))
        mysql.connection.commit()
        cursor.close()
        flash("Çalışanın covid bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik7"))
    else:
        return render_template("veri7.html")


# Elemanın COVID bilgisini görüntüleme, güncelleme ve silme
@app.route("/veri/8")
@login_required
def istatistik8():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From covid order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        covid = cursor.fetchall()
        return render_template("veri8.html",covid = covid)
    else:
        return render_template("veri8.html")



@app.route("/veri/8/delete/<string:id>")
@login_required
def covidsil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from covid where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from covid where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik8"))
    else:
        flash("Bu numaralı id'de hastalık bulunmamaktadır.")
        return redirect(url_for("istatistik8"))


@app.route("/veri/8/edit/<string:id>",methods=["GET","POST"])
@login_required
def covidduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM covid WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        print(data[0])
        return render_template('veri9.html',covid=data[0])
    else:
        newtcno = request.form['tcno']
        newyakalanigitarih = request.form['yakalandigitarih']
        newnegatiftarih = request.form['negatiftarih']
        newasidurumu = request.form['asidurumu']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE covid SET tc_no = %s, yakalandigi_tarih = %s, negatif_tarihi = %s, asi_id = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newyakalanigitarih,newnegatiftarih,newasidurumu,id))
        mysql.connection.commit()
        if result > 0:
            flash("COVID bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik8"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik8"))




# Çalışan Ekleme
@app.route("/veri/23",methods = ["GET","POST"])
@login_required
def istatistik23():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        temaslitc = request.form.get('temaslitc')
        sorgu = "Insert into temasli_calisanlar(tc_no,temasli_tcno) VALUES(%s,%s)"
        cursor = mysql.connection.cursor()
        cursor.execute(sorgu,(tcno,temaslitc,))
        mysql.connection.commit()
        cursor.close()
        flash("Temaslı bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik23"))
    else:
        return render_template("veri23.html")







# Elemanın Temaslı Çalışan bilgisini görüntüleme, güncelleme ve silme
@app.route("/veri/21")
@login_required
def istatistik21():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From temasli_calisanlar"
    result = cursor.execute(sorgu)
    if result > 0:
        temasli = cursor.fetchall()
        return render_template("veri21.html",temasli = temasli)
    else:
        return render_template("veri21.html")



@app.route("/veri/21/delete/<string:id>")
@login_required
def temaslisil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from temasli_calisanlar where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from temasli_calisanlar where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik21"))
    else:
        flash("Bu numaralı id'e ait bir kişi bulunmamaktadır.")
        return redirect(url_for("istatistik21"))


@app.route("/veri/21/edit/<string:id>",methods=["GET","POST"])
@login_required
def temasliduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM temasli_calisanlar WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        return render_template('veri22.html',temasli=data[0])
    else:
        newtcno = request.form['tcno']
        newtemaslitc = request.form['temaslitc']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE covid SET tc_no = %s, temasli_tcno = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newtemaslitc,id))
        mysql.connection.commit()
        if result > 0:
            flash("Temaslı bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik21"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik21"))




# Belirti bilgisi ekleme
@app.route("/veri/24",methods=["GET", "POST"])
@login_required
def istatistik24():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        belirti = request.form.get('belirti')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into belirtiler(tc_no,belirti_ismi) VALUES(%s,%s)"
        cursor.execute(sorgu,(tcno,belirti))
        mysql.connection.commit()
        cursor.close()
        flash("Çalışanın belirti bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik24"))
    else:
        return render_template("veri24.html")



# Belirti bilgisini güncelleme ve silme
@app.route("/veri/25")
@login_required
def istatistik25():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From belirtiler order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        belirtiler = cursor.fetchall()
        return render_template("veri25.html",belirtiler = belirtiler)
    else:
        return render_template("veri25.html")


@app.route("/veri/25/delete/<string:id>")
@login_required
def belirtisil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from belirtiler where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from belirtiler where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik25"))
    else:
        flash("Bu numaralı id'de bir belirti bulunmamaktadır.")
        return redirect(url_for("istatistik25"))


@app.route("/veri/25/edit/<string:id>",methods=["GET","POST"])
@login_required
def belirtiduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM belirtiler WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        return render_template('veri26.html',belirtiler=data[0])
    else:
        newtcno = request.form['tcno']
        newbelirti = request.form['belirti']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE belirtiler SET tc_no = %s, belirti_ismi = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newbelirti,id))
        mysql.connection.commit()
        if result > 0:
            flash("Belirti bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik25"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik25"))





# Kronik hastalık bilgisi ekleme
@app.route("/veri/27",methods=["GET", "POST"])
@login_required
def istatistik27():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        kronik = request.form.get('kronik')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into kronik_hastaliklar(tc_no,kronik_hastaligi) VALUES(%s,%s)"
        cursor.execute(sorgu,(tcno,kronik))
        mysql.connection.commit()
        cursor.close()
        flash("Kronik hastalık bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik27"))
    else:
        return render_template("veri27.html")





# Kronik hastalık bilgisini güncelleme ve silme
@app.route("/veri/28")
@login_required
def istatistik28():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From kronik_hastaliklar"
    result = cursor.execute(sorgu)
    if result > 0:
        kronik = cursor.fetchall()
        return render_template("veri28.html",kronik = kronik)
    else:
        return render_template("veri28.html")


@app.route("/veri/28/delete/<string:id>")
@login_required
def kroniksil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from kronik_hastaliklar where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from kronik_hastaliklar where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik28"))
    else:
        flash("Bu numaralı id'de bir belirti bulunmamaktadır.")
        return redirect(url_for("istatistik28"))


@app.route("/veri/28/edit/<string:id>",methods=["GET","POST"])
@login_required
def kronikduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM kronik_hastaliklar WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        return render_template('veri29.html',kronik=data[0])
    else:
        newtcno = request.form['tcno']
        newkronik = request.form['kronik']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE kronik_hastaliklar SET tc_no = %s, kronik_hastaligi = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newkronik,id))
        mysql.connection.commit()
        if result > 0:
            flash("Kronik hastalık bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik28"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik28"))




# Elemana çalışma bilgisi ekleme
@app.route("/veri/10",methods=["GET", "POST"])
@login_required
def istatistik10():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        haftaicigiris = request.form.get('haftaicigiris')
        haftaicicikis = request.form.get('haftaicicikis')
        cumartesigiris = request.form.get('cumartesigiris')
        cumartesicikis = request.form.get('cumartesicikis')
        pazargiris = request.form.get('pazargiris')
        pazarcikis = request.form.get('pazarcikis')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into calisma_sureleri(tc_no,haftaicigiris,haftaicicikis,cumartesigiris,cumartesicikis,pazargiris,pazarcikis) VALUES(%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(sorgu,(tcno,haftaicigiris,haftaicicikis,cumartesigiris,cumartesicikis,pazargiris,pazarcikis))
        mysql.connection.commit()
        cursor.close()
        flash("Çalışanın çalışma bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik10"))
    else:
        return render_template("veri10.html")



# Elemanın çalışma bilgisini güncelleme ve silme
@app.route("/veri/11")
@login_required
def istatistik11():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From calisma_sureleri order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        gun = cursor.fetchall() 
        return render_template("veri11.html",gun = gun)
    else:
        return render_template("veri11.html")


@app.route("/veri/11/delete/<string:id>")
@login_required
def calismasaatisil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from calisma_sureleri where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from calisma_sureleri where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik11"))
    else:
        flash("Bu numaralı id'de bir çalışma süresi bulunmamaktadır.")
        return redirect(url_for("istatistik11"))


@app.route("/veri/11/edit/<string:id>",methods=["GET","POST"])
@login_required
def calismasaatiduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM calisma_sureleri WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        return render_template('veri12.html',gun=data[0])
    else:
        newtcno = request.form['tcno']
        newhaftaicigiris = request.form['haftaicigiris']
        newhaftaicicikis = request.form['haftaicicikis']
        newcumartesigiris = request.form['cumartesigiris']
        newcumartesicikis = request.form['cumartesicikis']
        newpazargiris = request.form['pazargiris']
        newpazarcikis = request.form['pazarcikis']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE calisma_sureleri SET tc_no = %s, haftaicigiris = %s, haftaicicikis = %s, cumartesigiris = %s, cumartesicikis = %s, pazargiris = %s, pazarcikis = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newhaftaicigiris,newhaftaicicikis,newcumartesigiris,newcumartesicikis,newpazargiris,newpazarcikis,id))
        mysql.connection.commit()
        if result > 0:
            flash("Çalışma saati bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik11"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik11"))


# Hobi bilgisi ekleme
@app.route("/veri/13",methods=["GET", "POST"])
@login_required
def istatistik13():
    if request.method == "POST":
        tcno = request.form.get('tcno')
        hobi_ismi = request.form.get('hobi_ismi')
        cursor = mysql.connection.cursor()
        sorgu = "Insert into eleman_hobileri(tc_no,hobi_ismi) VALUES(%s,%s)"
        cursor.execute(sorgu,(tcno,hobi_ismi))
        mysql.connection.commit()
        cursor.close()
        flash("Çalışanın hobi bilgisi başarılı bir şekilde kaydedildi","success")
        return redirect(url_for("istatistik13"))
    else:
        return render_template("veri13.html")



@app.route("/veri/14")
@login_required
def istatistik14():
    cursor = mysql.connection.cursor()
    sorgu = "Select * From eleman_hobileri order by tc_no"
    result = cursor.execute(sorgu)
    if result > 0:
        hobi = cursor.fetchall()
        return render_template("veri14.html",hobi = hobi)
    else:
        return render_template("veri14.html")




@app.route("/veri/14/delete/<string:id>")
@login_required
def hobisil(id):
    cursor = mysql.connection.cursor()
    sorgu = "Select * from eleman_hobileri where id = %s"
    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from eleman_hobileri where id = %s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        return redirect(url_for("istatistik14"))
    else:
        flash("Bu numaralı id'de hastalık bulunmamaktadır.")
        return redirect(url_for("istatistik14"))


@app.route("/veri/14/edit/<string:id>",methods=["GET","POST"])
@login_required
def hobiduzenle(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = "SELECT * FROM eleman_hobileri WHERE id = %s"
        result = cursor.execute(sorgu,(id,))
        data = cursor.fetchall()
        cursor.close()
        print(data[0])
        return render_template('veri15.html',hobi=data[0])
    else:
        newtcno = request.form['tcno']
        newhobi = request.form['hobi_ismi']
        cursor = mysql.connection.cursor()
        sorgu = "UPDATE eleman_hobileri SET tc_no = %s, hobi_ismi = %s WHERE id = %s"
        result = cursor.execute(sorgu,(newtcno,newhobi,id))
        mysql.connection.commit()
        if result > 0:
            flash("Hobi bilgisi başarılı bir şekilde güncellendi","success")
            return redirect(url_for("istatistik14"))
        else:
            flash("Bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz.","danger")
            return redirect(url_for("istatistik14"))


# Eğitim durumu ve COVID arasındaki istatistiki bilgi (1)
@app.route("/veri/16")
@login_required
def istatistik16():
    cursor = mysql.connection.cursor()
    cursor2 = mysql.connection.cursor()
    cursor3 = mysql.connection.cursor()
    sorgu = "select DISTINCT e.* from eleman e, covid c where doktora = '0' and yuksek_lisans = '0' and e.tc_no in (Select c.tc_no from covid);" #Lisans
    sorgu2 = "select DISTINCT e.* from eleman e, covid c where doktora = '0' and yuksek_lisans <> '0' and e.tc_no in (Select c.tc_no from covid);" #Yüksek Lisans
    sorgu3 = "select DISTINCT e.* from eleman e, covid c where doktora <> '0' and e.tc_no in (Select c.tc_no from covid);" # Doktora
    result = cursor.execute(sorgu)
    result2 = cursor2.execute(sorgu2)
    result3 = cursor3.execute(sorgu3)
    if result or result2 or result3 > 0:
        lisans = cursor.fetchall()
        ylisans = cursor2.fetchall()
        doktora = cursor3.fetchall()
        lisansadet = len(lisans)
        yukseklisansadet = len(ylisans)
        doktoraadet = len(doktora)
        return render_template("veri16.html",lisans = lisans, ylisans = ylisans, doktora = doktora,lisansadet=lisansadet,yukseklisansadet=yukseklisansadet,doktoraadet=doktoraadet)
    else:
        flash("Bir hata oluştu!","danger")
        return render_template("veri16.html")


#Elemanlar arasında görülen en yaygın üç hastalık türü ve o hastalığa sahip olan elemanların listesi
@app.route("/veri/17", methods=["GET","POST"])
@login_required
def istatistik17():
    if request.method == "GET" or request.method == "POST":
        cursor = mysql.connection.cursor() 
        cursor0 = mysql.connection.cursor()  
        cursor1 = mysql.connection.cursor()
        cursor2 = mysql.connection.cursor()   
        sorgu = "SELECT hastalik_adi, COUNT(hastalik_adi) AS hastaliklar FROM hasta GROUP BY hastalik_adi ORDER BY hastaliklar DESC LIMIT 3;"       
        result = cursor.execute(sorgu) 
        if result > 0:
            data = cursor.fetchall()  
            hastalik_adi0 = data[0]['hastalik_adi']
            hastalik_adi1 = data[1]['hastalik_adi']
            hastalik_adi2 = data[2]['hastalik_adi']
            sorgu0 = "SELECT DISTINCT e.tc_no, e.isim, e.soyisim from eleman e, hasta h where e.tc_no in (SELECT DISTINCT tc_no from hasta where hastalik_adi= '" + hastalik_adi0 + "');"
            sorgu1 = "SELECT DISTINCT e.tc_no, e.isim, e.soyisim from eleman e, hasta h where e.tc_no in (SELECT DISTINCT tc_no from hasta where hastalik_adi= '" + hastalik_adi1 + "');"
            sorgu2 = "SELECT DISTINCT e.tc_no, e.isim, e.soyisim from eleman e, hasta h where e.tc_no in (SELECT DISTINCT tc_no from hasta where hastalik_adi= '" + hastalik_adi2 + "');"
            result0 = cursor0.execute(sorgu0)
            result1 = cursor1.execute(sorgu1)
            result2 = cursor2.execute(sorgu2)
            if result0 and result1 and result2 > 0:
                data0 = cursor0.fetchall()     
                data1 = cursor1.fetchall()        
                data2 = cursor2.fetchall()
                return render_template("veri17.html", data=data, data0=data0, data1= data1, data2= data2)
            else:
                flash("Bu sayfada henüz herhangi bir veri bulunmamaktadır","danger")
                return redirect(url_for("dashboard"))
            


@app.route("/veri/18", methods=["GET","POST"])
@login_required
def istatistik18():
    if request.method == "POST":
        sehiradi = request.form.get('sehiradi')
        cursor = mysql.connection.cursor()
        sorgu = "SELECT h.hastalik_adi, COUNT(hastalik_adi) as hastaliklar from eleman e, hasta h where h.tc_no in (Select e.tc_no from eleman where e.dogum_yeri= '"+ str(sehiradi) +"') GROUP BY hastalik_adi order by hastaliklar desc limit 3;"
        result = cursor.execute(sorgu)
        if result == 0:
            flash("Aranan şehire ait bir hastalık bulunamadı...","warning")
            return render_template("veri18.html")
        else:
            data = cursor.fetchall()
            return render_template("veri18.html",data = data, sehiradi=sehiradi)
    else:
        return render_template("veri18.html") # render_template ile yazmadığım için 1 saat boşa gitti



@app.route("/veri/19")
@login_required
def istatistik19():
    if request.method == "GET" or request.method == "POST":
        cursor = mysql.connection.cursor() 
        cursor0 = mysql.connection.cursor()  
        cursor1 = mysql.connection.cursor()
        cursor2 = mysql.connection.cursor()   
        sorgu = "select ilac, COUNT(ilac) as adet_sayisi from hasta GROUP BY ilac ORDER BY adet_sayisi desc LIMIT 3;"       
        result = cursor.execute(sorgu) 
        if result > 0:
            data = cursor.fetchall()  
            ilac_adi0 = data[0]['ilac']
            ilac_adi1 = data[1]['ilac']
            ilac_adi2 = data[2]['ilac']
            sorgu0 = "Select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi, h.ilac from eleman e, covid c, hasta h where e.tc_no in (Select c.tc_no from covid where c.tc_no in (Select h.tc_no from hasta where  h.ilac = '" + ilac_adi0 + "'));"
            sorgu1 = "Select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi, h.ilac from eleman e, covid c, hasta h where e.tc_no in (Select c.tc_no from covid where c.tc_no in (Select h.tc_no from hasta where  h.ilac = '" + ilac_adi1 + "'));"
            sorgu2 = "Select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi, h.ilac from eleman e, covid c, hasta h where e.tc_no in (Select c.tc_no from covid where c.tc_no in (Select h.tc_no from hasta where  h.ilac = '" + ilac_adi2 + "'));"
            result0 = cursor0.execute(sorgu0)
            result1 = cursor1.execute(sorgu1)
            result2 = cursor2.execute(sorgu2)
            if result0 and result1 and result2 > 0:
                data0 = cursor0.fetchall()     
                data1 = cursor1.fetchall()        
                data2 = cursor2.fetchall()
                bir = len(data0)
                iki = len(data1)
                uc = len(data2)
                return render_template("veri19.html", data=data, data0=data0, data1= data1, data2= data2,bir = bir, iki = iki, uc = uc)
            else:
                flash("Bu sayfada henüz herhangi bir veri bulunmamaktadır","danger")
                return redirect(url_for("dashboard"))
            



@app.route("/veri/20",methods=["GET","POST"])
@login_required
def istatistik20():
    if request.method == "POST":
        ilacadi = request.form.get('ilacadi')
        cursor = mysql.connection.cursor()
        sorgu = "select DISTINCT c.tc_no, c.yakalandigi_tarih, c.negatif_tarihi, h.ilac from covid c, hasta h where c.tc_no in (Select h.tc_no from hasta where  h.ilac = '" + ilacadi + "');"
        result = cursor.execute(sorgu)
        if result == 0:
            flash("Bu ilacı kullanıp korona olan çalışan bulunmamaktadır","warning")
            return render_template("veri20.html")
        else:
            data = cursor.fetchall()
            return render_template("veri20.html",data = data, ilacadi=ilacadi)
    else:
        return render_template("veri20.html") # render_template ile yazmadığım için 1 saat boşa gitti



# Aşı vurulma durumuna göre covide yakalanma durumu ve oranı
@app.route("/veri/30")
@login_required
def istatistik30():
    cursor = mysql.connection.cursor()
    cursor2 = mysql.connection.cursor()
    cursor3 = mysql.connection.cursor()
    sorgu = "select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi,c.asi_id from covid c, eleman e where e.tc_no in (Select DISTINCT c.tc_no from covid where c.asi_id = '0' GROUP BY tc_no)" #Aşı olmayıp korona olanlar
    sorgu2 = "select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi,c.asi_id from covid c, eleman e where e.tc_no in (Select DISTINCT c.tc_no from covid where c.asi_id = '1' GROUP BY tc_no)" #Sinovac aşısı olup korona olanlar
    sorgu3 = "select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih,c.negatif_tarihi,c.asi_id from covid c, eleman e where e.tc_no in (Select DISTINCT c.tc_no from covid where c.asi_id = '2' GROUP BY tc_no)" #Biontech aşısı olup korona olanlar
    result = cursor.execute(sorgu)
    result2 = cursor2.execute(sorgu2)
    result3 = cursor3.execute(sorgu3)
    if result or result2 or result3 > 0:
        asisiz = cursor.fetchall()
        sinovac = cursor2.fetchall()
        biontech = cursor3.fetchall()
        bir = len(asisiz)
        iki = len(sinovac)
        uc = len(biontech)
        return render_template("veri30.html",asisiz = asisiz, sinovac = sinovac, biontech = biontech, bir = bir, iki = iki, uc = uc)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri30.html")



# Belirli bir kronik hastalığa göre koronanın geçme süresini gösteren sorgu
@app.route("/veri/31",methods=["GET","POST"])
@login_required
def istatistik31():
    if request.method == "POST":
        hastalikadi = request.form.get('hastalikadi')
        cursor = mysql.connection.cursor()
        sorgu = "Select c.tc_no,c.yakalandigi_tarih,c.negatif_tarihi,TIMESTAMPDIFF(DAY,c.yakalandigi_tarih,c.negatif_tarihi) as gecen_sure ,k.kronik_hastaligi from covid c, kronik_hastaliklar k where c.tc_no in (SELECT k.tc_no from kronik_hastaliklar where k.kronik_hastaligi = '"+ str(hastalikadi) +"');"
        result = cursor.execute(sorgu)
        if result == 0:
            flash("Bu hastalığa sahip korona geçirmiş çalışan bulunmamaktadır","warning")
            return render_template("veri31.html")
        else:
            data = cursor.fetchall()
            return render_template("veri31.html",data = data, hastalikadi=hastalikadi)
    else:
        return render_template("veri31.html") 




# Aşı vurulma durumuna göre covide yakalanma durumu ve oranı
@app.route("/veri/32")
@login_required
def istatistik32():
    cursor = mysql.connection.cursor()  #A-
    cursor2 = mysql.connection.cursor() #A+
    cursor3 = mysql.connection.cursor() #B-
    cursor4 = mysql.connection.cursor() #B+
    cursor5 = mysql.connection.cursor() #AB-
    cursor6 = mysql.connection.cursor() #AB+
    cursor7 = mysql.connection.cursor() #0-
    cursor8 = mysql.connection.cursor() #0+
    sorgu = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'A-')"
    sorgu2 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'A+')"
    sorgu3 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'B-')"
    sorgu4 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'B+')"
    sorgu5 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'AB-')"
    sorgu6 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = 'AB+')"
    sorgu7 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = '0-')"
    sorgu8 = "select e.tc_no, e.isim, e.soyisim, e.kan_grubu, c.yakalandigi_tarih,c.negatif_tarihi from eleman e, covid c where c.tc_no in (Select e.tc_no from eleman where e.kan_grubu = '0+')"
    result = cursor.execute(sorgu)      #A-
    result2 = cursor2.execute(sorgu2)   #A+
    result3 = cursor3.execute(sorgu3)   #B-
    result4 = cursor4.execute(sorgu4)   #B+
    result5 = cursor5.execute(sorgu5)   #AB-
    result6 = cursor6.execute(sorgu6)   #AB+
    result7 = cursor7.execute(sorgu7)   #0-
    result8 = cursor8.execute(sorgu8)   #0+
    if result or result2 or result3 or result4 or result5 or result6 or result7 or result8 > 0:
        a1 = cursor.fetchall()
        a2 = cursor2.fetchall()
        b1 = cursor3.fetchall()
        b2 = cursor4.fetchall()
        ab1 = cursor5.fetchall()
        ab2 = cursor6.fetchall()
        sıfır1 = cursor7.fetchall()
        sıfır2 = cursor8.fetchall()
        ua1 = len(a1)
        ua2 = len(a2)
        ub1 = len(b1)    
        ub2 = len(b2)
        uab1 = len(ab1)    
        uab2 = len(ab2)        
        usıfır1 = len(sıfır1)  
        usıfır2 = len(sıfır2)              
        return render_template("veri32.html",a1 = a1, a2= a2, b1 = b1, b2 = b2, ab1= ab1, ab2= ab2, sıfır1 = sıfır1, sıfır2 = sıfır2, ua1=ua1,ua2=ua2,ub1=ub1,ub2=ub2,uab1=uab1,uab2=uab2,usıfır1 = usıfır1, usıfır2 = usıfır2)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri32.html")






# COVID'e yakalananlar arasında en sık görülen 3 belirti ve o belirtiye sahip olan çalışanlar
@app.route("/veri/33", methods=["GET","POST"])
@login_required
def istatistik33():
    if request.method == "GET" or request.method == "POST":
        cursor = mysql.connection.cursor() 
        cursor0 = mysql.connection.cursor()  
        cursor1 = mysql.connection.cursor()
        cursor2 = mysql.connection.cursor()   
        sorgu = "Select belirti_ismi, COUNT(belirti_ismi) as gorulme_sayisi from belirtiler GROUP BY belirti_ismi ORDER BY gorulme_sayisi desc LIMIT 3;"       
        result = cursor.execute(sorgu) 
        if result > 0:
            data = cursor.fetchall()  
            belirti_adi0 = data[0]['belirti_ismi']
            belirti_adi1 = data[1]['belirti_ismi']
            belirti_adi2 = data[2]['belirti_ismi']
            sorgu0 = "Select DISTINCT e.tc_no, e.isim, e.soyisim, b.belirti_ismi from eleman e, belirtiler b where e.tc_no in (Select b.tc_no where b.belirti_ismi = '" + belirti_adi0 + "');"
            sorgu1 = "Select DISTINCT e.tc_no, e.isim, e.soyisim, b.belirti_ismi from eleman e, belirtiler b where e.tc_no in (Select b.tc_no where b.belirti_ismi = '" + belirti_adi1 + "');"
            sorgu2 = "Select DISTINCT e.tc_no, e.isim, e.soyisim, b.belirti_ismi from eleman e, belirtiler b where e.tc_no in (Select b.tc_no where b.belirti_ismi = '" + belirti_adi2 + "');"
            result0 = cursor0.execute(sorgu0)
            result1 = cursor1.execute(sorgu1)
            result2 = cursor2.execute(sorgu2)
            if result0 and result1 and result2 > 0:
                data0 = cursor0.fetchall()     
                data1 = cursor1.fetchall()        
                data2 = cursor2.fetchall()
                sifir = len(data0)
                bir = len(data1)
                iki = len(data2)
                return render_template("veri33.html", data=data, data0=data0, data1= data1, data2= data2,sifir=sifir,bir=bir,iki=iki)
            else:
                flash("Bu sayfada henüz herhangi bir veri bulunmamaktadır","danger")
                return redirect(url_for("dashboard"))
            






# Temas eden ve edilen kişi listei
@app.route("/veri/34")
@login_required
def istatistik34():
    cursor = mysql.connection.cursor()
    sorgu = "Select e.tc_no, e.isim, e.soyisim, t.temasli_tcno from eleman e, temasli_calisanlar t where e.tc_no in (SELECT t.tc_no from temasli_calisanlar) order by e.isim;"
    result = cursor.execute(sorgu)
    if result > 0:
        data = cursor.fetchall()
        print(len(data))
        return render_template("veri34.html",data = data)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri34.html")








# Aşı türüne ve durumuna göre covidi kaç günde atlatma bilgisi
@app.route("/veri/35")
@login_required
def istatistik35():
    cursor = mysql.connection.cursor()
    cursor2 = mysql.connection.cursor()
    cursor3 = mysql.connection.cursor()
    sorgu = "Select DISTINCT e.tc_no, e.isim, e.soyisim, TIMESTAMPDIFF(DAY,c.yakalandigi_tarih,c.negatif_tarihi) as fark, c.asi_id from covid c, eleman e where e.tc_no in (SELECT c.tc_no from covid where c.asi_id = '0');" #Aşı olmayanlar
    sorgu2 = "Select DISTINCT e.tc_no, e.isim, e.soyisim, TIMESTAMPDIFF(DAY,c.yakalandigi_tarih,c.negatif_tarihi) as fark, c.asi_id from covid c, eleman e where e.tc_no in (SELECT c.tc_no from covid where c.asi_id = '1');" #Sinovac aşısı olanlar
    sorgu3 = "Select DISTINCT e.tc_no, e.isim, e.soyisim, TIMESTAMPDIFF(DAY,c.yakalandigi_tarih,c.negatif_tarihi) as fark, c.asi_id from covid c, eleman e where e.tc_no in (SELECT c.tc_no from covid where c.asi_id = '2');" #Biontech aşısı olanlar
    result = cursor.execute(sorgu)
    result2 = cursor2.execute(sorgu2)
    result3 = cursor3.execute(sorgu3)
    if result or result2 or result3 > 0:
        asisiz = cursor.fetchall()
        sinovac = cursor2.fetchall()
        biontech = cursor3.fetchall()
        bir = len(asisiz)
        iki = len(sinovac)
        uc = len(biontech)
        return render_template("veri35.html",asisiz = asisiz, sinovac = sinovac, biontech = biontech, bir=bir, iki=iki, uc=uc)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri35.html")



# Haftasonu çalışıp korona olanların listesi
@app.route("/veri/36")
@login_required
def istatistik36():
    cursor = mysql.connection.cursor()
    cursor2 = mysql.connection.cursor()
    sorgu = "Select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih, c.negatif_tarihi, cs.cumartesigiris,cs.cumartesicikis,cs.pazargiris, cs.pazarcikis from eleman e, covid c, calisma_sureleri cs where e.tc_no in (Select c.tc_no from covid where c.tc_no in (Select cs.tc_no from calisma_sureleri where cs.cumartesigiris <> '0:00:00' or  cs.cumartesicikis <> '0:00:00' or cs.pazargiris <> '0:00:00' or cs.pazarcikis <> '0:00:00')) order by tc_no"
    sorgu2 = "Select * from calisma_sureleri where cumartesigiris <> '0:00:00' or  cumartesicikis <> '0:00:00' or pazargiris <> '0:00:00' or pazarcikis <> '0:00:00'"
    result = cursor.execute(sorgu)
    result2 = cursor2.execute(sorgu2)
    if result or result2> 0:
        data = cursor.fetchall()
        data2 = cursor2.fetchall() 
        korona_olan = len(data)
        toplamkisisayisi = len(data2)
        return render_template("veri36.html",data = data,korona_olan=korona_olan,toplamkisisayisi=toplamkisisayisi)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri36.html")



@app.route("/veri/37")
@login_required
def istatistik37():
    cursor = mysql.connection.cursor()
    sorgu = "select DISTINCT e.tc_no,e.isim, e.soyisim,c.yakalandigi_tarih,c.negatif_tarihi from eleman e, hasta h, covid c where e.tc_no in (select c.tc_no from covid where c.tc_no in (SELECT tc_no from hasta GROUP BY tc_no ORDER BY COUNT(tc_no) desc) and timestampdiff(month,c.negatif_tarihi,curdate())<=1)"
    result = cursor.execute(sorgu)
    if result > 0:
        data = cursor.fetchall()
        return render_template("veri37.html",data = data)
    else:
        flash("Bir hata oluştur","danger")
        return render_template("veri37.html")


@app.route("/veri/38", methods=["GET","POST"])
@login_required
def istatistik38():
    if request.method == "POST":
        hastalikadi = request.form.get('hastalikadi')
        cursor = mysql.connection.cursor()
        sorgu = "select e.tc_no, e.isim, e.soyisim, c.yakalandigi_tarih, c.negatif_tarihi,h.hastalik_adi, c.asi_id  from eleman e, covid c, hasta h where e.tc_no in (Select c.tc_no from covid where c.asi_id = '2' and c.tc_no in (Select h.tc_no from hasta where h.hastalik_adi = '"+hastalikadi+"')) order by e.tc_no"
        result = cursor.execute(sorgu)
        if result == 0:
            flash("Aranan hastalığa ait bir veri bulunamadı...","warning")
            return render_template("veri38.html")
        else:
            data = cursor.fetchall()
            return render_template("veri38.html",data = data, hastalikadi=hastalikadi)
    else:
        return render_template("veri38.html") 


if __name__ == "__main__":
    app.run(debug=True,port=5000)
