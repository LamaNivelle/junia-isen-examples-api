from fastapi.testclient import TestClient
from examples.examples import app
import os
import pytest
from unittest.mock import patch

client = TestClient(app)


def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}

def test_read_examples(mocker):
    mock_db_connect = mocker.patch("examples.examples.db_connect")
    
    mock_cursor = mock_db_connect.return_value.cursor.return_value
    mock_cursor.fetchall.return_value = [(1, "Hello world!"), (2, "Hello world!"), (3, "Hello world!")]
    
    response = client.get("/examples")
    
    assert response.status_code == 200

    examples = response.json().get("examples", [])
    

    assert examples[0][1] == "Hello world!"


@patch("examples.examples.BlobServiceClient")  
def test_read_quotes(mock_blob_service_client):

    mock_container_client = mock_blob_service_client.return_value.get_container_client.return_value
    mock_container_client.download_blob.return_value.readall.return_value = b'[{"author": "Author Name", "quote": "This is a quote."}]'
    
    response = client.get("/quotes")
    
    assert response.status_code == 200
    assert response.json() == {"quotes": [{"author": "Author Name", "quote": "This is a quote."}]}