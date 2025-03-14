from fastapi import APIRouter, Depends, HTTPException, File, UploadFile
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.match_service import (
    get_matches,
    get_match,
    create_match as create_match_service,
    update_match as update_match_service,
    delete_match as delete_match_service,
    get_session,
)
from ..models.schemas import MatchCreate, Match
from pathlib import Path
import shutil
import uuid

router = APIRouter()

ALLOWED_EXTENSIONS = {".png", ".jpg", ".jpeg"}
BASE_DIR = Path(__file__).resolve().parent.parent
IMG_MATCHES_DIR = BASE_DIR / "assets/img_matches"
# Create the directory if necessary
IMG_MATCHES_DIR.mkdir(parents=True, exist_ok=True)
print(f"Assets directory resolved to: {IMG_MATCHES_DIR.resolve()}")
if not IMG_MATCHES_DIR.exists():
    print("Directory does not exist, creating...")
    IMG_MATCHES_DIR.mkdir(parents=True, exist_ok=True)
else:
    print("Directory already exists.")

# CRUD - Read all matches
@router.get("/matches", response_model=list[Match])
async def read_matches(session: AsyncSession = Depends(get_session)): 
    """Retrieve all matches."""
    return await get_matches(session)

# CRUD - Read a specific match by ID
@router.get("/matches/{match_id}", response_model=Match)
async def read_match(match_id: int, session: AsyncSession = Depends(get_session)):  
    """Retrieve a specific match by ID."""
    match = await get_match(session, match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    return match

# CRUD - Create a new match
@router.post("/matches", response_model=Match)
async def create_match(match: MatchCreate, session: AsyncSession = Depends(get_session)): 
    """Create a new match."""
    match_data = await create_match_service(session, match)  
    return match_data

# CRUD - Update an existing match
@router.put("/matches/{match_id}", response_model=Match)
async def update_match(match_id: int, match: MatchCreate, session: AsyncSession = Depends(get_session)): 
    """Update an existing match."""
    updated_match = await update_match_service(session, match_id, match)  
    if not updated_match:
        raise HTTPException(status_code=404, detail="Match not found")
    return updated_match

# CRUD - Delete a match
@router.delete("/matches/{match_id}")
async def delete_match(match_id: int, session: AsyncSession = Depends(get_session)):  
    """Delete a match."""
    deleted = await delete_match_service(session, match_id)  
    if not deleted:
        raise HTTPException(status_code=404, detail="Match not found")
    return {"message": "Match deleted successfully"}


# Save image on the associated directory and return the path
@router.post("/matches/image")
async def upload_image(image : UploadFile = File()):
    # Check file extension
    file_extension = Path(image.filename).suffix.lower()
    if file_extension not in ALLOWED_EXTENSIONS:
        return HTTPException(detail="Unauthorised extension : only png, jpg and jpeg file are allowed.", status_code=400)
    
    # New image path
    unique_filename = f"{uuid.uuid4()}{file_extension}"
    img_location = IMG_MATCHES_DIR / unique_filename
    print(img_location)
    # Image recording
    try:
        file_content = await image.read()
        with img_location.open("wb") as buffer:
            buffer.write(file_content)
        print(f"Successfully written to {img_location.resolve()}")
        # with img_location.open("w") as f:
        #     f.write("Test content")
        # print(f"Test file created: {img_location.resolve()}")
        return {"path":f"http://localhost:8000/assets/img_matches/{unique_filename}"}
    except Exception as error:
        return HTTPException(detail="Error during the saving : "+str(error), status_code=500)

