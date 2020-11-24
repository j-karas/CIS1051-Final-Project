WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

--Calls from the push library.
push = require 'push'

--Sets up the window for the game and centers everything according.
push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, {
    fullscreen = false,
    vsync = true,
    resizeable = true
})

gameState = 'start'
--RULES:
--The goal of blackjack is to beat the dealer's hand without going over 21.

--Face cards are worth 10. Aces are worth 1 or 11, whichever makes a better hand.

--Each player starts with two cards, one of the dealer's cards is hidden until the end.

--To 'Hit' is to ask for another card. To 'Stand' is to hold your total and end your turn.

--If you go over 21 you bust, and the dealer wins regardless of the dealer's hand.

--If you are dealt 21 from the start (Ace & 10), you got a blackjack.

--Blackjack usually means you win 1.5 the amount of your bet. Depends on the casino.

--Dealer will hit until his/her cards total 17 or higher.

--Doubling is like a hit, only the bet is doubled and you only get one more card.

--Split can be done when you have two of the same card - the pair is split into two hands.

--Splitting also doubles the bet, because each new hand is worth the original bet.

--You can only double/split on the first move, or first move of a hand created by a split.

--You cannot play on two aces after they are split.

--You can double on a hand resulting from a split, tripling or quadrupling you bet.


function love.load()
    -- Sets the Window Title to say "Blackjak" because it's the title of the game.
    love.window.setTitle('Blackjak')

    --Creates the fonts that will be used throughout the game.
    smallFont = love.graphics.newFont('Carnevalee Freakshow.ttf', 25)
    largeFont = love.graphics.newFont('Carnevalee Freakshow.ttf', 100)

    --Loads all the card images, in the future, I will see if I can load this in a seperate file so this code doesn't take up many lines in main.
    twoClubs = love.graphics.newImage('cards/2C.png')
    twoDiamonds = love.graphics.newImage('cards/2D.png')
    twoHearts = love.graphics.newImage('cards/2H.png')
    twoSpades = love.graphics.newImage('cards/2S.png')
    threeClubs = love.graphics.newImage('cards/3C.png')
    threeDiamonds = love.graphics.newImage('cards/3D.png')
    threeHearts = love.graphics.newImage('cards/3H.png')
    threeSpades = love.graphics.newImage('cards/3S.png')
    fourClubs = love.graphics.newImage('cards/4C.png')
    fourDiamonds = love.graphics.newImage('cards/4D.png')
    fourHearts = love.graphics.newImage('cards/4H.png')
    fourSpades = love.graphics.newImage('cards/4S.png')
    fiveClubs = love.graphics.newImage('cards/5C.png')
    fiveDiamonds = love.graphics.newImage('cards/5D.png')
    fiveHearts = love.graphics.newImage('cards/5H.png')
    fiveSpades = love.graphics.newImage('cards/5S.png')
    sixClubs = love.graphics.newImage('cards/6C.png')
    sixDiamonds = love.graphics.newImage('cards/6D.png')
    sixHearts = love.graphics.newImage('cards/6H.png')
    sixSpades = love.graphics.newImage('cards/6S.png')
    sevenClubs = love.graphics.newImage('cards/7C.png')
    sevenDiamonds = love.graphics.newImage('cards/7D.png')
    sevenHearts = love.graphics.newImage('cards/7H.png')
    sevenSpades = love.graphics.newImage('cards/7S.png')
    eightClubs = love.graphics.newImage('cards/8C.png')
    eightDiamonds = love.graphics.newImage('cards/8D.png')
    eigthHearts = love.graphics.newImage('cards/8H.png')
    eigthSpades = love.graphics.newImage('cards/8S.png')
    nineClubs = love.graphics.newImage('cards/9C.png')
    nineDiamonds = love.graphics.newImage('cards/9D.png')
    nineHearts = love.graphics.newImage('cards/9H.png')
    nineSpades = love.graphics.newImage('cards/9S.png')
    tenClubs = love.graphics.newImage('cards/10C.png')
    tenDiamonds = love.graphics.newImage('cards/10D.png')
    tenHearts = love.graphics.newImage('cards/10H.png')
    tenSpades = love.graphics.newImage('cards/10S.png')
    aceClubs = love.graphics.newImage('cards/AC.png')
    aceDiamonds = love.graphics.newImage('cards/AD.png')
    aceHearts = love.graphics.newImage('cards/AH.png')
    aceSpades = love.graphics.newImage('cards/AS.png')
    jackClubs = love.graphics.newImage('cards/JC.png')
    jackDiamonds = love.graphics.newImage('cards/JD.png')
    jackHearts = love.graphics.newImage('cards/JH.png')
    jackSpades = love.graphics.newImage('cards/JS.png')
    kingClubs = love.graphics.newImage('cards/KC.png')
    kingDiamonds = love.graphics.newImage('cards/KD.png')
    kingHearts = love.graphics.newImage('cards/KH.png')
    kingSpades = love.graphics.newImage('cards/KS.png')
    queenClubs = love.graphics.newImage('cards/QC.png')
    queenDiamonds = love.graphics.newImage('cards/QD.png')
    queenHearts = love.graphics.newImage('cards/QH.png')
    queenSpades = love.graphics.newImage('cards/QS.png')

    cardBack = love.graphics.newImage('cards/red_back.png')


end

function love.draw()
    --Applies the push attributes.
    push:start()

    --This will create the temporary background of a green table. It will be changed depending on the gameState later on.
    love.graphics.clear(1 / 255, 140 / 255, 1 / 255, 255 / 255)


    --This if statement will display the welcome message to the user.
    if gameState == 'start' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Welcome to Blackjak', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press and hold "R" to learn the instructions of Blackjak.', 0, 200, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press "Enter" to join a table and begin the game!', 0, 225, VIRTUAL_WIDTH, 'center')
        
        --This will scale the card images because they currently too big.
        love.graphics.scale(0.3, 0.3)
        love.graphics.draw(aceSpades, 375/0.3, 650/0.3, VIRTUAL_WIDTH)
        love.graphics.draw(jackSpades, 475/0.3, 675/0.3, VIRTUAL_WIDTH)

    end

    if gameState == 'rules' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Test', 0, 40, VIRTUAL_WIDTH, 'center')
    
    end

    push:finish()
end

function love.update(dt)

    --If the player presses and holds 'r' they can go to the rules page and read how to play.
    if love.keyboard.isDown('r') then
        gameState = 'rules'
    else
        gameState = 'start'
    end

end




