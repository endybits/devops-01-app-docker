FROM python:3.9

WORKDIR /app

COPY makefile /app/makefile
COPY requirements.txt /app/requirements.txt

RUN make install

COPY ./app /app/app

EXPOSE 80

CMD [ "python3", "app/main.py" ]