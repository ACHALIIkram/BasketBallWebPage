from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.training_service import (
    get_training,
    get_all_trainings,
    get_training_for_team,
    create_training,
    update_training,
    delete_training,
    get_session,
)
from ..models.schemas import TrainingCreate, TrainingUpdate, Training

router = APIRouter()

@router.get("/trainings/", response_model=list[Training])
async def read_all_trainings(session: AsyncSession = Depends(get_session)):
    return await get_all_trainings(session)

@router.get("/trainings/{trainig_id}", response_model=Training)
async def retrieve_training(training_id: int, session: AsyncSession = Depends(get_session)):
    training = await get_training(session, training_id)
    if not training:
        raise HTTPException(status_code=404, detail="Training not found")
    return training

@router.get("/trainings/team/{team_id}", response_model=list[Training])
async def get_trainings_for_team(team_id: int, session: AsyncSession = Depends(get_session)):
    trainings = await get_training_for_team(session, team_id)
    if not trainings:
        raise HTTPException(status_code=404, detail="Training not found")
    return trainings

@router.post("/trainings", response_model=Training)
async def create_new_training(training_data: TrainingCreate, session: AsyncSession = Depends(get_session)):
    return await create_training(session, training_data)

@router.put("/trainings/{training_id}", response_model=Training)
async def update_existing_training(training_id: int, training_data: TrainingUpdate, session: AsyncSession = Depends(get_session)):
    updated_training = await update_training(session, training_id, training_data)
    if not updated_training:
        raise HTTPException(status_code=404, detail="Training not found")
    return updated_training

@router.delete("/trainings/{training_id}", response_model=Training)
async def delete_existing_training(training_id: int, session: AsyncSession = Depends(get_session)):
    deleted_training = await delete_training(session, training_id)
    if not deleted_training:
        raise HTTPException(status_code=404, detail="Training not found")
    return deleted_training
