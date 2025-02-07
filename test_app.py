import pytest
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_greetme(client):
    response = client.get('/')
    assert response.data==b'hello devops'
    assert response.status_code==200


def test_page(client):
    response = client.get('/page1')
    assert response.data==b'welcome to page1'
    assert response.status_code==200
    