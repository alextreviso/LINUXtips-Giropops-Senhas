FROM python:3.8.2-alpine
WORKDIR /usr/app
COPY . ./
RUN pip install --no-cache-dir -r requirements.txt
ARG REDIS_HOST
ENV REDIS_HOST=$REDIS_HOST
EXPOSE 5000
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0"]
