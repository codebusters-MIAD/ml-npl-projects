from pydantic import BaseModel, HttpUrl, field_validator
from typing import Literal

class PredictRequest(BaseModel):
    url: HttpUrl
    model_type: Literal["classification", "regression"]

    @field_validator("url")
    @classmethod
    def check_url_length(cls, v: HttpUrl):
        if len(str(v)) > 2000:
            raise ValueError("The 'url' must be less than 2000 characters.")
        return v
