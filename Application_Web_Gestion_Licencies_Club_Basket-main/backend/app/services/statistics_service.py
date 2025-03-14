from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import Statistics
from ..db.db import AsyncSessionLocal

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Retrieve all statistics
async def get_all_statistics(session: AsyncSession):
    async with session.begin():
        query = select(Statistics)
        result = await session.execute(query)
        return result.scalars().all()

# Retrieve a specific statistics by ID
async def get_statistics_by_id(session: AsyncSession, statistics_id: int):
    async with session.begin():
        query = select(Statistics).where(Statistics.idStat == statistics_id)
        result = await session.execute(query)
        return result.scalar_one_or_none()


# Create new statistics
async def create_statistics(statistics_data, session: AsyncSession):
    statistics_dict = statistics_data.dict()

    if statistics_dict.get("ThreePtsFieldGoalsMade") is None:
        statistics_dict["ThreePtsFieldGoalsMade"] = 0

    if statistics_dict.get("ThreePtsFieldGoalsAttempted") is None:
        statistics_dict["ThreePtsFieldGoalsAttempted"] = 0

    async with session.begin():
        statistics = Statistics(**statistics_dict)
        session.add(statistics)
        await session.commit()
        return statistics



# Update existing statistics
async def update_statistics(session: AsyncSession, statistics_id: int, statistics_data):
    async with session.begin():
        query = select(Statistics).where(Statistics.idStat == statistics_id)
        result = await session.execute(query)
        statistics = result.scalar_one_or_none()

        if statistics:
            for key, value in statistics_data.dict().items():
                if value is not None:  # Only update non-None values
                    setattr(statistics, key, value)
            await session.commit()
            return statistics
        else:
            return None

# Delete statistics by ID
async def delete_statistics(session: AsyncSession, statistics_id: int):
    async with session.begin():
        query = select(Statistics).where(Statistics.idStat == statistics_id)
        result = await session.execute(query)
        statistics = result.scalar_one_or_none()

        if statistics:
            await session.delete(statistics)
            await session.commit()
            return True
        else:
            return False
