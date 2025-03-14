from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import User, Player, Admin
from ..db.db import AsyncSessionLocal

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Retrieve all users
async def get_users(session: AsyncSession):
    query = select(User)
    result = await session.execute(query)
    return result.scalars().all()

# Retrieve a user by ID
async def get_user(session: AsyncSession, user_id: int):
    query = select(User).where(User.idUser == user_id)
    result = await session.execute(query)
    return result.scalar_one_or_none()

# Create a new user
async def create_user(session: AsyncSession, user_data):
    new_user = User(**user_data.dict())
    
    if user_data.idTeam:
        new_user.idTeam = user_data.idTeam
    
    session.add(new_user)
    await session.commit()
    await session.refresh(new_user)
    return new_user


# Update an existing user
async def update_user(session: AsyncSession, user_id: int, user_data):
    user = await get_user(session, user_id)
    if user:
        for key, value in user_data.dict().items():
            if key == "idTeam":
                setattr(user, key, value)
            else:
                setattr(user, key, value)
        await session.commit()
        await session.refresh(user)
    return user


# Delete a user
async def delete_user(session: AsyncSession, user_id: int):
    user = await get_user(session, user_id)
    if user:
        await session.delete(user)
        await session.commit()
    return user



# Retrieve all users by team ID
async def get_users_by_team(session: AsyncSession, team_id: int):
    query = select(User).where(User.idTeam == team_id)
    result = await session.execute(query)
    return result.scalars().all()


# Remove a user from a team (set idTeam to None)
async def remove_user_from_team(session: AsyncSession, user_id: int):
    user = await get_user(session, user_id)
    if user:
        user.idTeam = None
        await session.commit()
        await session.refresh(user)
    return user

