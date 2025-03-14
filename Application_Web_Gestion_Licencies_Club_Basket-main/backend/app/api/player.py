from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.player_service import (
    get_players_with_stats,
    get_session,
    add_player,
    delete_player
)
from ..models.schemas import PlayerOut, PlayerCreate

router = APIRouter()

@router.get("/players", response_model=list[PlayerOut])
async def get_players(db: AsyncSession = Depends(get_session)):
    players = await get_players_with_stats(db)
    return players

@router.get("/players/{player_id}", response_model=PlayerOut)
async def get_player(player_id: int, db: AsyncSession = Depends(get_session)):
    players = await get_players_with_stats(db, player_id)
    if not players:
        raise HTTPException(status_code=404, detail="Player not found")
    return players[0]

@router.post("/players", response_model=PlayerOut)
async def create_player(player: PlayerCreate, db: AsyncSession = Depends(get_session)):
    new_player = await add_player(db, player)
    return new_player

@router.delete("/players/{player_id}", status_code=204)
async def remove_player(player_id: int, db: AsyncSession = Depends(get_session)):
    success = await delete_player(db, player_id)
    if not success:
        raise HTTPException(status_code=404, detail="Player not found")
    return {"detail": "Player deleted successfully"}
