from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.statistics_service import (
    get_all_statistics,
    get_statistics_by_id,
    create_statistics,
    update_statistics,
    delete_statistics,
    get_session,
)
from ..models.schemas import StatisticsCreate, StatisticsUpdate, Statistics

router = APIRouter()

# Create new statistics
@router.post("/statistics/", response_model=Statistics, status_code=201)
async def create_new_statistics(
    statistics_data: StatisticsCreate, session: AsyncSession = Depends(get_session)
):
    return await create_statistics(statistics_data, session)

# Get all statistics
@router.get("/statistics/", response_model=list[Statistics])
async def read_all_statistics(session: AsyncSession = Depends(get_session)):
    return await get_all_statistics(session)

# Get statistics by ID
@router.get("/statistics/{statistics_id}")
async def read_statistics(statistics_id: int, session: AsyncSession = Depends(get_session)):
    statistics = await get_statistics_by_id(session, statistics_id)
    if statistics is None:
        raise HTTPException(status_code=404, detail="Statistics not found")
    return statistics

# Update statistics by ID
@router.put("/statistics/{statistics_id}", response_model=Statistics)
async def update_existing_statistics(
    statistics_id: int,
    statistics_data: StatisticsUpdate,
    session: AsyncSession = Depends(get_session),
):
    statistics = await update_statistics(statistics_id, statistics_data, session)
    if not statistics:
        raise HTTPException(status_code=404, detail="Statistics not found")
    return statistics

# Delete statistics by ID
@router.delete("/statistics/{statistics_id}")
async def delete_statistics_entry(statistics_id: int, session: AsyncSession = Depends(get_session)):
    success = await delete_statistics(session, statistics_id)
    
    if success:
        return {"message": "Statistique supprimée avec succès"}
    else:
        raise HTTPException(status_code=404, detail="Statistique non trouvée")
