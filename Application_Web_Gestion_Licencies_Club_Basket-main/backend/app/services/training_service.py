from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import Training
from ..db.db import AsyncSessionLocal

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Retrieve all training
async def get_all_trainings(session: AsyncSession):
    async with session.begin():
        query = select(Training)  
        result = await session.execute(query)
        return result.scalars().all()

# Retrieve a specific training by ID
async def get_training(session: AsyncSession, training_id: int):
    async with session.begin():
        query = select(Training).where(Training.idTraining == training_id)
        result = await session.execute(query)
        return result.scalar_one_or_none()

# Retrieve all training for a specific team
async def get_training_for_team(session: AsyncSession, team_id: int):
    async with session.begin():
        query = select(Training).where(Training.idTeam == team_id)
        result = await session.execute(query)
        return result.scalars().all()

# Create a training
async def create_training(session: AsyncSession, training_data):
    async with session.begin():
        training = Training(**training_data.dict())
        session.add(training)
        await session.commit()
        return training

# Update an existing training
async def update_training(session: AsyncSession, training_id: int, training_data):
    async with session.begin():
        query = select(Training).where(Training.idTraining == training_id)
        result = await session.execute(query)
        training = result.scalar_one_or_none()

        if training:
            for key, value in training_data.dict().items():
                if value is not None:  # Only update non-None values
                    setattr(training, key, value)
            await session.commit()
            return training
        else:
            return None

# Delete a training
async def delete_training(session: AsyncSession, training_id: int):
    async with session.begin():
        query = select(Training).where(Training.idTraining == training_id)
        result = await session.execute(query)
        training = result.scalar_one_or_none()

        if training:
            await session.delete(training)
            await session.commit()
            return training
        else:
            return None
