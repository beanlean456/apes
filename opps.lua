-- Define the function that will be executed by the executor
function saveAndLoadTools()
    -- Function to save player's tools to server storage
    local function saveTools(player)
        local playerTools = player:GetChildren() -- Get all of the player's tools
    
        -- Create an empty table to store the tool data
        local toolData = {}
    
        -- Iterate through each of the player's tools and add them to the toolData table
        for _, tool in pairs(playerTools) do
            if tool:IsA("Tool") then -- Only add tools to the table
                table.insert(toolData, {
                    Name = tool.Name,
                    Handle = tool.Handle,
                    Parent = tool.Parent
                })
            end
        end
    
        -- Save the tool data to server storage
        game:GetService("ServerStorage"):SetData("PlayerTools_" .. player.Name, toolData)
    end
    
    -- Function to load player's tools from server storage
    local function loadTools(player)
        local toolData = game:GetService("ServerStorage"):GetData("PlayerTools_" .. player.Name)
    
        -- Iterate through the tool data and recreate the tools
        for _, tool in pairs(toolData) do
            local newTool = Instance.new("Tool")
            newTool.Name = tool.Name
            newTool.Handle = tool.Handle
            newTool.Parent = player
        end
    end
    
    -- Connect the save and load functions to the appropriate events
    game.Players.PlayerAdded:Connect(function(player)
        loadTools(player)
    end)
    game.Players.PlayerRemoving:Connect(function(player)
        saveTools(player)
    end)
end
-- Call the function
saveAndLoadTools()
