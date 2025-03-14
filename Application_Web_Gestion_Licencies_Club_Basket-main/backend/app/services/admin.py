from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..models.model import Admin
from ..db.db import AsyncSessionLocal
from fastapi import HTTPException

# Dependency for getting a session
async def get_session():
    async with AsyncSessionLocal() as session:
        yield session

# Login
async def login(session: AsyncSession, login_request):
    query = select(Admin).filter(Admin.login == login_request.login)
    
    try:
        result = await session.execute(query)
        admin = result.scalar_one_or_none()
        
        if admin is None:
            raise HTTPException(status_code=404, detail="User not found")
        
        if admin.password == login_request.password:
            return {"message": "Login successful"}
        else:
            raise HTTPException(status_code=401, detail="Invalid password")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")