from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import NoResultFound
from ..models.model import Match
from ..db.db import AsyncSessionLocal

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Retrieve all matches
async def get_matches(session: AsyncSession):
    query = select(Match)
    result = await session.execute(query)
    return result.scalars().all()

# Retrieve a match by ID
async def get_match(session: AsyncSession, match_id: int):
    query = select(Match).where(Match.idMatch == match_id)
    result = await session.execute(query)
    match = result.scalar_one_or_none()
    return match

# Create a new match
async def create_match(session: AsyncSession, match_data):
    new_match = Match(**match_data.dict())
    session.add(new_match)
    await session.commit()
    await session.refresh(new_match)  # Rafraîchit pour inclure l'ID généré
    return new_match

# Update an existing match
async def update_match(session: AsyncSession, match_id: int, match_data):
    query = select(Match).where(Match.idMatch == match_id)
    result = await session.execute(query)
    match = result.scalar_one_or_none()
    if not match:
        return None

    for key, value in match_data.dict().items():
        setattr(match, key, value)  # Mise à jour des attributs

    await session.commit()
    await session.refresh(match)  # Rafraîchit pour inclure les modifications
    return match

# Delete a match
async def delete_match(session: AsyncSession, match_id: int):
    query = select(Match).where(Match.idMatch == match_id)
    result = await session.execute(query)
    match = result.scalar_one_or_none()
    if not match:
        return None

    await session.delete(match)
    await session.commit()
    return match
