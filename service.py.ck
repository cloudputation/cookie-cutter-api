import sys
import os
import http
import json, typing
import requests
import shutil


from fastapi import FastAPI, File, UploadFile
from typing import List
from starlette.responses import Response, FileResponse
from pydantic import BaseModel



app = FastAPI()


class PrettyJSONResponse(Response):
    media_type = "application/json"

    def render(self, content: typing.Any) -> bytes:
        return json.dumps(
            content,
            ensure_ascii=False,
            allow_nan=False,
            indent=4,
            separators=(", ", ": "),
        ).encode("utf-8")


@app.get("/health", response_class=PrettyJSONResponse)
async def return_status():
    API_VERSION_FILE = "API_VERSION"
    API_VERSION = open(API_VERSION_FILE, "r").read().replace("\n", "")
    health_manifest = {
        "API status": "OK",
        "API version": API_VERSION,
        "Service Name" "{{.Service.Name}}",
        "Service Group" "{{.Service.Group}}"
    }
    return health_manifest
