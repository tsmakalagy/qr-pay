from flask import Flask, jsonify, abort, make_response, request
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
from pyfcm import FCMNotification
import time

mysql = MySQL()
app = Flask(__name__, static_url_path="")

push_service = FCMNotification(api_key="AAAA15J8O4I:APA91bFxk1U7gxkRWyyAxLPnlhAhiBygEfFDPD8oZzDtMAvFOG12m72JhwRYGG6TjeIYHlRg-DhSXHXGonaSMUjosTPg3vpWyOVFtc3YlrkGk3xHNRAoABSXXR1UO51z1OJUN6Mv5aJJ")

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
    
@app.route('/qrpay/api/v1.0/create_user_email',methods=['POST'])
def createUserEmail():
    try:

        if not request.json or not 'email' in request.json or not 'password' in request.json or not 'fb_id' in request.json or not 'name' in request.json or not 'app_token' in request.json:
            abort(400)

        _email = request.json['email']
        _name = request.json['name']
        _password = request.json['password']
        _fb_id = request.json['fb_id']
        _app_token = request.json['app_token']

        # validate the received values
        if _name and _email and _password and _fb_id and _app_token:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_createUserEmail',(_name, _email,_hashed_password, _fb_id, _app_token))
            data = cursor.fetchone()

            if data and len(data) > 0:
                conn.commit()
                return jsonify({'user_id':data[0]})
            else:
                return jsonify({'error1':'User not found'})
        else:
            return jsonify({'error_fields':'Enter the required fields'})

    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/create_user_phone',methods=['POST'])
def createUserPhone():
    try:

        if not request.json or not 'email' in request.json or not 'phone_number' in request.json or not 'password' in request.json or not 'fb_id' in request.json or not 'name' in request.json or not 'app_token' in request.json:
            abort(400)

        _email = request.json['email']
        _phone_number = request.json['phone_number']
        _name = request.json['name']
        _password = request.json['password']
        _fb_id = request.json['fb_id']
        _app_token = request.json['app_token']

        # validate the received values
        if _name and _phone_number and _email and _password and _fb_id and _app_token:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_createUserPhone',(_name, _email, _phone_number, _hashed_password, _fb_id, _app_token))
            data = cursor.fetchone()

            if data and len(data) > 0:
                conn.commit()
                return jsonify({'user_id':data[0]})
            else:
                return jsonify({'error1':'User not found'})
        else:
            return jsonify({'error_fields':'Enter the required fields'})

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
            
            cursor.callproc('sp_getUserById',[_emitter])
            data_user = cursor.fetchall()
        
            if len(data_user) > 0:
                if check_password_hash(str(data_user[0][2]),_password):
                    cursor.callproc('sp_createTransaction',(_amount,_emitter,_receiver,_type))
                    data = cursor.fetchall()
                    if len(data) is 0:
                        conn.commit()
                        
                        ## Send notification
                        cursor.callproc('sp_getUserAppToken',_receiver)
                        data_token = cursor.fetchone()
                        if len(data_token) > 0:
                            registration_id = data_token[0];
                            user_name = data_token[1];
                            message_title = "Money received"
                            message_body = "Hi " + user_name + ", you received " + _amount + " MGA today."
                            data_message = {
                                "title" : message_title,
                                "body" : message_body
                            }
                            
                            result = push_service.notify_single_device(registration_id=registration_id, data_message=data_message)
                            #result = push_service.notify_single_device(registration_id=registration_id, message_title=message_title, message_body=message_body)
                            return jsonify(result)
                        
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
    
def list_transactions(_trs):
    if len(_trs) > 0:
        _tr = [{'tr_id': _tr[0], 'tr_amount':_tr[1], 'tr_emitter': _tr[2], 'tr_receiver': _tr[3], 'tr_date': _tr[4], 'tr_type': _tr[5]} for _tr in _trs]
        return _tr
    
@app.route('/qrpay/api/v1.0/transaction/<user_id>', methods = ['GET'])
def getTransactionByUserId(user_id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_getAllTransactionsByUser',[user_id])
        data = cursor.fetchall()
        
        if data and len(data) > 0:
            return jsonify({'transactions':list_transactions(data)})
        else:
            return jsonify({'message':'No transactions for this user !'})
    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/balance/<user_id>', methods = ['GET'])
def getBalanceByUserId(user_id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_getBalanceByUser',[user_id])
        data = cursor.fetchone()
        
        if data and len(data) > 0:
            return jsonify({'user_id':user_id, 'balance':data[0]})
        else:
            return jsonify({'error':'Balance error !'})
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
        cursor.callproc('sp_getUserById',[user_id])
        data = cursor.fetchall()
        
        if data and len(data) > 0:
            return jsonify({'users':list_users(data)})
        else:
            return jsonify({'message':'User not found !'})
    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/get_user_email', methods = ['POST'])
def getUserByEmail():
    try:
        if not request.json or not 'email' in request.json or not 'fb_id' in request.json or not 'app_token' in request.json:
            abort(400)
        
        _email = request.json['email']
        _fb_id = request.json['fb_id']
        _app_token = request.json['app_token']
        

        # validate the received values
        if _email and _fb_id and _app_token:
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_getUserByEmailAndUID',(_email, _fb_id, _app_token))
            data = cursor.fetchone()

            if len(data) > 0:
                conn.commit()
                return jsonify({'user_id':data[0]})
            else:
                return jsonify({'message':'User not found !'})
        else:
            return jsonify({'error_email':'Error email or id !'})
    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/check_user_phone', methods = ['POST'])
def getUserByPhone():
    try:
        if not request.json or not 'phone_number' in request.json or not 'fb_id' in request.json or not 'app_token' in request.json:
            abort(400)
        
        _phone_number = request.json['phone_number']
        _fb_id = request.json['fb_id']
        _app_token = request.json['app_token']
        

        # validate the received values
        if _phone_number and _fb_id and _app_token:
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_getUserByPhoneAndUID',(_phone_number, _fb_id, _app_token))
            data = cursor.fetchone()

            if len(data) > 0:
                conn.commit()
                return jsonify({'user_id':data[0], 'user_email':data[1]})
            else:
                return jsonify({'message':'User not found !'})
        else:
            return jsonify({'error_email':'Error email or id !'})
    except Exception as e:
        return jsonify({'error2':str(e)})
    
@app.route('/qrpay/api/v1.0/users', methods = ['GET'])
def getAllUsers():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_getAllUsers')
        data = cursor.fetchall()
        
        if data and len(data) > 0:
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

            if data and len(data) > 0:
                return jsonify({'users':list_users(data)})
            else:
                return jsonify({'message':'User not found !'})            
        else:
            return jsonify({'warning':'Enter the required fields'})

    except Exception as e:
        return jsonify({'error2':str(e)})

if __name__ == '__main__':
    app.run(debug=True)