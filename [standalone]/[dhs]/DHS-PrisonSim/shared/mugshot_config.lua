MugshotConfig = {}

if Config.MLOSelection == 'prompt-prison' then
    MugshotConfig.MugshotLocation = vector3(1696.72, 2588.23, 44.92) -- Location of the Suspect
    MugshotConfig.MugshotInmateHeading = 91.59                       -- Direction Suspsect is facing
    MugshotConfig.MugshotCameraLocation = vector3(1695.31, 2588.2, 46.5) -- Location of the Camera
    MugshotConfig.MugshotCameraRotation = vector3(0.0, 0.0, 268.17) -- Rotation of the Camera
    MugshotConfig.BoardHeader = "Bolingbroke Penitentiary"           -- Header that appears on the board
elseif Config.MLOSelection == 'molo-alcatraz' then
    MugshotConfig.MugshotLocation = vector3(3858.67, -10.39, 5.71) -- Location of the Suspect
    MugshotConfig.MugshotInmateHeading = 268.21                       -- Direction Suspsect is facing
    MugshotConfig.MugshotCameraLocation = vector3(3860.67, -10.29, 6.71) -- Location of the Camera
    MugshotConfig.MugshotCameraRotation = vector3(0.0, 0.0, 90.0) -- Rotation of the Camera
    MugshotConfig.BoardHeader = "Alcatraz"           -- Header that appears on the board
elseif Config.MLOSelection == 'gabz-prison' then
    MugshotConfig.MugshotLocation = vector3(1844.61, 2594.4, 45.02) -- Location of the Suspect
    MugshotConfig.MugshotInmateHeading = 84.96                       -- Direction Suspsect is facing
    MugshotConfig.MugshotCameraLocation = vector3(1842.45, 2594.28, 46.01) -- Location of the Camera
    MugshotConfig.MugshotCameraRotation = vector3(0.0, 0.0, 267.22) -- Rotation of the Camera
    MugshotConfig.BoardHeader = "Bolingbroke Penitentiary"           -- Header that appears on the board
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end
