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




