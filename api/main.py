from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class Device(BaseModel):
    device_id: str
    status: str

devices = [
    {"device_id": "PART1234", "status": "ACTIVE"},
    {"device_id": "PART456", "status": "INACTIVE"}
]

@app.get("/devices")
def get_devices(status: str | None = None, device_id: str | None = None):
    result = devices
    if status:
        return [d for d in devices if d["status"] == status]
    if device_id:
        result = [d for d in result if d["device_id"] == device_id]
    if device_id:
        result = [d for d in result if d["device_id"] != device_id]
        raise  HTTPException(status_code=404, detail="User not found")
    return result

@app.get("/devices/{device_id}")
def get_user(device_id: str):
    for d in devices:
        if d["device_id"] == device_id:
            return d
    raise HTTPException(status_code=404, detail="User not found")



@app.post("/devices")
def add_device(device: Device):
    return {"added": device.device_id}

@app.put("/devices")
def add_device(device: Device):
    devices.append(device.model_dump())
    return {"added": device.device_id}

@app.delete("/devices/{device_id}")
def remove_device(device_id: str):
    for d in devices:
        if d["device_id"] == device_id:
            devices.remove(d)
            #return {"removed": device_id}
        #raise HTTPException(status_code=404, detail="User not found")