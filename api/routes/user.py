import flask

import api
from api.models.user import User


@api.app.route('/users', methods=['GET'])
def get_users():
    return flask.jsonify([User(name='Tom').to_dict()])
