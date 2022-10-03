from flask import *
from flask_mysqldb import *

App = Flask(__name__)

App.secret_key = "HenilCode"

App.config['MYSQL_HOST'] = "localhost"
App.config['MYSQL_USER'] = "root"
App.config['MYSQL_PASSWORD'] = ""
App.config['MYSQL_DB'] = "flaskDB"
conn = MySQL(App)

@App.route("/")
def home():
    if not session.get('SESS_NAME'):
        session['SESS_NAME'] = False
    curs = conn.connection.cursor()
    curs.execute("select * from message")
    message = curs.fetchall()
    return render_template("live.html",CR_USER=session['SESS_NAME'],chat = message)


@App.route("/login")
def login():
    if session.get('SESS_NAME'):
        return redirect("/")
    return render_template("login.html")


@App.route("/login/check",methods = ['POST'])
def checkLogin():
    if request.method == "POST":
        name = request.form["U_name"]
        password = request.form["U_password"]
        curs = conn.connection.cursor()
        curs.execute("select * from user_detail WHERE USER_NAME = %s AND USER_PASSWORD = %s",(name,password))
        result = curs.fetchone()
        if result:
            session['SESS_NAME'] = name
            conn.connection.commit()
            curs.close()
        else:
            return render_template("error.html",signup=False)
    else:
        return "Bad Request"
    return redirect("/")


@App.route("/signup")
def signup():
    return render_template("signup.html")


@App.route("/signup/check",methods = ['POST'])
def checkSignup():
    if request.method == "POST":
        name = request.form["U_name"]
        email = request.form["U_email"]
        password = request.form["U_password"]
        curs = conn.connection.cursor()
        try:
            curs.execute("insert into user_detail (USER_NAME, USER_EMAIL, USER_PASSWORD) values(%s,%s,%s)",(name,email,password))
        except:
            return render_template("error.html",uname = name,signup=True)
        conn.connection.commit()
        curs.close()
    return redirect("/login")

@App.route("/chat",methods = ['POST','GET'])
def chat():
    if request.method == "POST" and 'User_Chat' in request.form:     
        name = session['SESS_NAME']
        chat = request.form['User_Chat']
        curs = conn.connection.cursor()
        curs.execute("insert into message (SENDER,MESSAGE) values (%s,%s)",(name,chat))
        conn.connection.commit()
        curs.close()
    else:
        name = session['SESS_NAME']
        Ufile = request.files['file']
        UR_file = request.files['file']
        Ufile.save("./uploads/"+Ufile.filename) 
        curs = conn.connection.cursor()
        curs.execute("insert into message (SENDER,FILE,T_FILE) values (%s,%s,%s)",(name,Ufile.filename,UR_file.filename))
        conn.connection.commit()
        curs.close()
        return redirect("/")
    return redirect("/")

@App.route("/logout")
def logout():
    session.pop("SESS_NAME",None)
    return redirect("/login")
    
App.run(debug=True , host="localhost")
