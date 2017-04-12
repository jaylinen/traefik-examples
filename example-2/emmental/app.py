import socket
from flask import Flask, Response, render_template

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    firstchar = list(socket.gethostname())[-1]
    cheese_type = ord(firstchar) % 3

    images = [
        'https://www.valio.fi/mediafiles/b1eaddef-ced4-4d61-aee3-bb1a9e105f61/600x600r',
        'https://www.valio.fi/mediafiles/b714abd3-f1db-452b-b756-7bd7f2c852d5/600x600r',
        'https://www.valio.fi/mediafiles/d3d0f52b-e6f2-441e-b6e5-8ecfc61ce563/600x600r'
    ]

    return render_template('layout.html', pic=images[cheese_type])

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
