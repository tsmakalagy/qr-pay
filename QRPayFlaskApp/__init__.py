from flask import Flask, jsonify, abort, make_response, request
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
import time

mysql = MySQL()
app = Flask(__name__, static_url_path="")

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'mysql'
app.config['MYSQL_DATABASE_DB'] = 'qr_pay'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

@app.errorhandler(400)
def not_found(error):
    return make_response(jsonify( { 'error': 'Bad request' } ), 400)

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify( { 'error': 'Not found' } ), 404)

@app.route('/qrpay/api/v1.0/create_user',methods=['POST'])
def createUser():
    try:

        if not request.json or not 'name' in request.json or not 'password' in request.json:
            abort(400)

        _name = request.json['name']
        _password = request.json['password']

        # validate the received values
        if _name and _password:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_createUser',(_name,_hashed_password))
            data = cursor.fetchall()

            if len(data) is 0:
                conn.commit()
                return jsonify({'message':'User created successfully !'})
            else:
                return jsonify({'error1':str(data[0])})
        else:
            return jsonify({'warning':'Enter the required fields'})

    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/create_transaction',methods=['POST'])
def createTransaction():
    try:

        if not request.json or not 'password' in request.json or not 'amount' in request.json or not 'emitter' in request.json or not 'receiver' in request.json or not 'type' in request.json:
            abort(400)

        _password = request.json['password']
        _amount = request.json['amount']
        _emitter = request.json['emitter']
        _receiver = request.json['receiver']
        _type = request.json['type']

        # validate the received values
        if _password and _amount and _emitter and _receiver and _type:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            
            cursor.callproc('sp_getUserById',_emitter)
            data_user = cursor.fetchall()
        
            if len(data_user) > 0:
                if check_password_hash(str(data_user[0][2]),_password):
                    cursor.callproc('sp_createTransaction',(_amount,_emitter,_receiver,_type))
                    data = cursor.fetchall()
                    if len(data) is 0:
                        conn.commit()
                        return jsonify({'message':'Transaction is successfull !'})
                    else:
                        return jsonify({'error1':str(data[0])})
                else:
                    return jsonify({'error_password': 'Password not match'})
            else:
                return jsonify({'error_user': 'User not found'})
        else:
            return jsonify({'error_required':'Enter the required fields'})

    except Exception as e:
        return jsonify({'error2':str(e)})
    

    
def list_users(_users):
    _list_users = {}
    if len(_users) > 0:
        _user = [{'user_id': _user[0], 'user_name': _user[1]} for _user in _users]
        return _user
    

@app.route('/qrpay/api/v1.0/user/<user_id>', methods = ['GET'])
def getUserById(user_id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_getUserById',(user_id))
        data = cursor.fetchall()
        
        if len(data) > 0:
            return jsonify({'users':list_users(data)})
        else:
            return jsonify({'message':'User not found !'})
    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/users', methods = ['GET'])
def getAllUsers():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_getAllUsers')
        data = cursor.fetchall()
        
        if len(data) > 0:
            return jsonify({'users':list_users(data)})
        else:
            return jsonify({'message':'User not found !'})
    except Exception as e:
        return jsonify({'error2':str(e)})

@app.route('/qrpay/api/v1.0/validate_user',methods=['POST'])
def validateUser():
    try:

        if not request.json or not 'id' in request.json or not 'password' in request.json:
            abort(400)

        _id = request.json['id']
        _password = request.json['password']

        # validate the received values
        if _id and _password:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_validateUser',(_id,_hashed_password))
            data = cursor.fetchall()

            if len(data) > 0:
                return jsonify({'users':list_users(data)})
            else:
                return jsonify({'message':'User not found !'})            
        else:
            return jsonify({'warning':'Enter the required fields'})

    except Exception as e:
        return jsonify({'error2':str(e)})

if __name__ == '__main__':
    app.run(debug=True)