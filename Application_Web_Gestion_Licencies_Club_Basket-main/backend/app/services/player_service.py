from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import Statistics, Player, User
from ..db.db import AsyncSessionLocal
from ..models.schemas import PlayerCreate
from sqlalchemy.orm import selectinload

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Service to retrieve one or more players with their names and stats
async def get_players_with_stats(db: AsyncSession, player_id: int = None):
    query = select(Player).options(selectinload(Player.user), selectinload(Player.statistic))

    if player_id:
        query = query.filter(Player.idUser == player_id)
    
    result = await db.execute(query)
    players = result.scalars().all()
    
    return players


async def add_player(db: AsyncSession, player_data: PlayerCreate):
    new_user = User(
        FirstName=player_data.user.FirstName,
        LastName=player_data.user.LastName,
        idTeam=player_data.user.idTeam
    )
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)

    stat = None
    if player_data.statistic:
        stat = Statistics(
            Rebounds=player_data.statistic.Rebounds,
            Points=player_data.statistic.Points,
            ThreePtsFieldGoalsMade=player_data.statistic.ThreePtsFieldGoalsMade,
            ThreePtsFieldGoalsAttempted=player_data.statistic.ThreePtsFieldGoalsAttempted,
            FreeThrowMade=player_data.statistic.FreeThrowMade,
            FreeThrowAttempted=player_data.statistic.FreeThrowAttempted
        )
        db.add(stat)
        await db.commit()
        await db.refresh(stat)

    new_player = Player(
        idUser=new_user.idUser,
        idStat=stat.idStat if stat else None
    )
    db.add(new_player)
    await db.commit()

    result = await db.execute(
        select(Player)
        .options(selectinload(Player.user), selectinload(Player.statistic))
        .filter(Player.idUser == new_player.idUser)
    )
    player_with_relations = result.scalars().first()

    return player_with_relations




async def delete_player(db: AsyncSession, player_id: int):
    query = select(Player).filter(Player.idUser == player_id)
    result = await db.execute(query)
    player = result.scalars().first()

    if not player:
        return False

    await db.delete(player)
    await db.commit()
    return True