from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.team_service import (
    get_teams,
    get_team,
    create_team,
    update_team,
    delete_team,
    get_session,
)
from ..models.schemas import TeamCreate, TeamUpdate, Team

router = APIRouter()

@router.get("/teams", response_model=list[Team])
async def retrieve_teams(session: AsyncSession = Depends(get_session)):
    teams = await get_teams(session)
    return teams

@router.get("/teams/{team_id}", response_model=Team)
async def retrieve_team(team_id: int, session: AsyncSession = Depends(get_session)):
    team = await get_team(session, team_id)
    if not team:
        raise HTTPException(status_code=404, detail="Team not found")
    return team

@router.post("/teams", response_model=Team)
async def create_new_team(team_data: TeamCreate, session: AsyncSession = Depends(get_session)):
    return await create_team(session, team_data)

@router.put("/teams/{team_id}", response_model=Team)
async def update_existing_team(team_id: int, team_data: TeamUpdate, session: AsyncSession = Depends(get_session)):
    updated_team = await update_team(session, team_id, team_data)
    if not updated_team:
        raise HTTPException(status_code=404, detail="Team not found")
    return updated_team

@router.delete("/teams/{team_id}", response_model=Team)
async def delete_existing_team(team_id: int, session: AsyncSession = Depends(get_session)):
    deleted_team = await delete_team(session, team_id)
    if not deleted_team:
        raise HTTPException(status_code=404, detail="Team not found")
    return deleted_team
