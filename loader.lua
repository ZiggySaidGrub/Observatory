Observatory = SMODS.current_mod

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 64,
    py = 64
})

if next(SMODS.find_mod("Retcon"))~=nil then Retcon.load("utils/") else
    assert(SMODS.load_file("utils/swap.lua"))
    assert(SMODS.load_file("utils/ui.lua"))
end