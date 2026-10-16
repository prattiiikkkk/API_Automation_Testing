from fastapi import FastAPI, HTTPException

app = FastAPI()

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