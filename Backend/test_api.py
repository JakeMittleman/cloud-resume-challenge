import unittest
import requests
import logging
import json

REQUEST_URI = "https://api.jakemittlemanresu.me/visits"

class TestApi(unittest.TestCase):

    def test_api(self):
        api_response = requests.get(REQUEST_URI)
        assert api_response.status_code == 200
        visit_count = api_response.json()["visit_count"]

        api_response = requests.get(REQUEST_URI)
        assert api_response.status_code == 200
        second_visit_count = api_response.json()["visit_count"]

        assert visit_count < second_visit_count

if __name__ == "__main__":
    unittest.main()