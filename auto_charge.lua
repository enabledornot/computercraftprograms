local function refuel()
    if turtle.getFuelLevel() < 50 then
        local slot = turtle.getSelectedSlot()
        turtle.select(16)
        turtle.refuel()
        turtle.select(slot)
    end
end
local function waitForFinish()
    os.sleep(0.5)
    while redstone.getInput("left") == true do
        -- print("waiting for redstone")
        os.sleep(0.05)
    end
end
local function chargeIron()
    print("charging iron")
    turtle.select(1)
    while turtle.getItemCount() > 0 do
        turtle.drop(1)
        turtle.select(2)
        turtle.drop(1)
        turtle.select(1)
        waitForFinish()
    end
end
local function chargeElse()
   print("charging else")
   turtle.select(1)
   while turtle.getItemCount() > 0 do
       turtle.drop(1)
       waitForFinish()
   end 
end
local function checkChest()
    turtle.select(1)
    if turtle.suckDown() then
        local item = turtle.getItemDetail()
        os.sleep(0.5)
        if item.name == "minecraft:iron_ingot" then
            while turtle.getItemCount(2) ~= turtle.getItemCount(1) do
                turtle.suckDown()
            end
            chargeIron()
        else
            chargeElse()
        end
    else
        return false
    end
end
while true do
    checkChest()
end