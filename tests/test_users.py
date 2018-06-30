from api.routes.user import get_users


def test_user_route(client):
    users = client.get('/users').get_json()

    assert len(users) == 1

    assert users[0].get('name') == 'Tom'
