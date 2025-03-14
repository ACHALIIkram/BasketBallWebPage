from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import Team
from ..db.db import AsyncSessionLocal

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Retrieve all teams
async def get_teams(session: AsyncSession):
    async with session.begin():
        query = select(Team)  
        result = await session.execute(query)
        return result.scalars().all()

# Retrieve a specific team by ID
async def get_team(session: AsyncSession, team_id: int):
    async with session.begin():
        query = select(Team).where(Team.idTeam == team_id)
        result = await session.execute(query)
        return result.scalar_one_or_none()

# Create a team
async def create_team(session: AsyncSession, team_data):
    async with session.begin():
        team = Team(**team_data.dict())
        session.add(team)
        await session.commit()
        return team

# Update an existing team
async def update_team(session: AsyncSession, team_id: int, team_data):
    async with session.begin():
        query = select(Team).where(Team.idTeam == team_id)
        result = await session.execute(query)
        team = result.scalar_one_or_none()

        if team:
            for key, value in team_data.dict().items():
                if value is not None:  # Only update non-None values
                    setattr(team, key, value)
            await session.commit()
            return team
        else:
            return None

# Delete a team
async def delete_team(session: AsyncSession, team_id: int):
    async with session.begin():
        query = select(Team).where(Team.idTeam == team_id)
        result = await session.execute(query)
        team = result.scalar_one_or_none()

        if team:
            await session.delete(team)
            await session.commit()
            return team
        else:
            return None
