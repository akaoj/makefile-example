from api.routes.article import get_articles


def test_article_route(client):
    articles = client.get('/articles').get_json()

    assert len(articles) == 1

    assert articles[0].get('title') == 'Howdy'
