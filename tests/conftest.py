import api

from pytest import fixture


@fixture(scope='session')
def client():
    api.app.config['TESTING'] = True
    client = api.app.test_client()

    return client
