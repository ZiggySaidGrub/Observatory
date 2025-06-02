Observatory = SMODS.current_mod

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 64,
    py = 64
})

if next(SMODS.find_mod("Retcon"))~=nil then Retcon.load("utils/") end