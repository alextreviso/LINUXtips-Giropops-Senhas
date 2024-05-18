FROM cgr.dev/chainguard/python:latest-dev as build
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt --user \
    && chmod 777 /home/nonroot/.local/lib/python3.12/site-packages/flask


FROM cgr.dev/chainguard/python:latest
WORKDIR /app
ARG REDIS_HOST
ENV REDIS_HOST=$REDIS_HOST
COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages/ /home/nonroot/.local/lib/python3.12/site-packages/
COPY --from=build /home/nonroot/.local/bin  /home/nonroot/.local/bin
COPY app.py .
COPY templates templates/
COPY static static/
ENV PATH=$PATH:/home/nonroot/.local/bin
EXPOSE 5000
ENTRYPOINT [ "flask" ]
CMD ["run", "--host=0.0.0.0"]