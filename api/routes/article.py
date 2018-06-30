import flask

import api
from api.models.article import Article
from api.models.user import User


@api.app.route('/articles', methods=['GET'])
def get_articles():
    tom = User(name='Tom')
    return flask.jsonify([
        Article(title='Howdy', content='First article!', author=tom).to_dict()
    ])
