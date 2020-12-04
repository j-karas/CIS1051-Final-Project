WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

--Calls from the push library.
push = require 'push'
Class = require 'class'

require 'Card'


--Sets up the window for the game and centers everything according.
push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, {
    fullscreen = false,
    vsync = true,
    resizeable = true
})

gameState = 'start'
handState = 'test'

playerMoney = 500
currentBet = 0
pointTotal = 0
cardValue = love.graphics.newImage('cards/red_back.png')

placeHolder = love.graphics.newImage('cards/red_back.png')



function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

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
    eightHearts = love.graphics.newImage('cards/8H.png')
    eightSpades = love.graphics.newImage('cards/8S.png')
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

    -- Sets the Window Title to say "Blackjak" because it's the title of the game.
    love.window.setTitle('Blackjak')

    --Creates the fonts that will be used throughout the game.
    smallFont = love.graphics.newFont('Carnevalee Freakshow.ttf', 25)
    largeFont = love.graphics.newFont('Carnevalee Freakshow.ttf', 100)
    gameFont = love.graphics.newFont('Carnevalee Freakshow.ttf', 50)

    --Loads all the card images, in the future, I will see if I can load this in a seperate file so this code doesn't take up many lines in main.

    love.keyboard.keysPressed = {}


end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

    if key == 'r' then
        gameState = 'rules'
    end

    if key == 's' then
        gameState = 'start'
    end

    if key == 'p' then
        gameState = 'play'
        playerMoney = 500
        currentBet = 0
        pointTotal = 0
    end

    if key == '5' then
        love.event.bet(50)
    end

    if key == '4' then
        love.event.bet(40)
    end

    if key == '3' then
        love.event.bet(30)
    end
    
    if key == '2' then
        love.event.bet(20)
    end

    if key == '1' then
        love.event.bet(10)
    end

    -- This is to test the drawing of the cards and assigning them a value
    if key == '8' then
        love.event.playhand()
    end


    love.keyboard.keysPressed[key] = true

end

--This is most likely not needed
function love.keyreleased(key)

end

--This is most likely not needed. I need to rewatch the mario workshop to see what they did with this function.
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
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
        love.graphics.printf('Press "R" to learn the instructions of Blackjak.', 0, 200, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press "Enter" to join a table and begin the game!', 0, 225, VIRTUAL_WIDTH, 'center')
        
        --This will scale the card images because they currently too big.
        love.graphics.scale(0.3, 0.3)
        love.graphics.draw(aceSpades, 375/0.3, 650/0.3, VIRTUAL_WIDTH)
        love.graphics.draw(jackSpades, 475/0.3, 675/0.3, VIRTUAL_WIDTH)

    end

    --This displays the rules on the rules page for the player.
    if gameState == 'rules' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Rules', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press 'S' to go back to the main screen. Press 'Enter' to join a table and begin a game!", 0, 175, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("1. The goal of blackjack is to beat the dealer's hand without going over 21.", 0, 200, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("2. Face cards are worth 10. Aces are worth 1 or 11, whichever makes a better hand.", 0, 225, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("3. Each player starts with two cards, one of the dealer's cards is hidden until the end.", 0, 250, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("4. To 'Hit' is to ask for another card. To 'Stand' is to hold your total and end your turn.", 0, 275, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("5. If you go over 21 you bust, and the dealer wins regardless of the dealer's hand.", 0, 300, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("6. If you are dealt 21 from the start (Ace & 10), you got a blackjack.", 0, 325, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("7. Blackjack means you win 1.5 the amount of your bet.", 0, 350, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("8. Dealer will hit until his/her cards total 17 or higher.", 0, 375, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("9. Doubling is like a hit, only the bet is doubled and you only get one more card.", 0, 400, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("10. Split can be done when you have two of the same card - the pair is split into two hands.", 0, 425, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("11. Splitting also doubles the bet, because each new hand is worth the original bet.", 0, 450, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("12. You can only double/split on the first move, or first move of a hand created by a split.", 0, 475, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("13. You cannot play on two aces after they are split.", 0, 500, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("14. You can double on a hand resulting from a split, tripling or quadrupling you bet.", 0, 525, VIRTUAL_WIDTH, 'center')
    
    end

    --This is the game layout.
    if gameState == 'play' then
        love.graphics.setFont(gameFont)
        love.graphics.printf("Player Balance:", 50, 50, VIRTUAL_WIDTH, 'left')
        love.graphics.print(playerMoney, 50, 100)
        love.graphics.printf("Current Bet:", 50, 150, VIRTUAL_WIDTH, 'left')
        love.graphics.print(currentBet, 50, 200)
        love.graphics.printf("Hand Point Total:", 50, 250, VIRTUAL_WIDTH, 'left')
        love.graphics.print(pointTotal, 50, 300)

        love.graphics.setFont(gameFont)
        love.graphics.printf("Player Hand:", 550, 100, VIRTUAL_WIDTH)
        
        love.graphics.scale(0.2,0.2)
        love.graphics.draw(cardValue, 600/0.2, 175/0.2)
        love.graphics.draw(placeHolder, 750/0.2, 175/0.2)

    end

    if handState == 'won' then
        love.graphics.scale(1.3,1.3)
        love.graphics.setFont(largeFont)
        love.graphics.setColor(100 / 255, 50 / 255, 255 / 255, 255 / 255)
        love.graphics.printf("You won your last hand!", 50, 50, VIRTUAL_WIDTH, 'center')
    end

    if handState == 'lost' then
        love.graphics.scale(1.3,1.3)
        love.graphics.setFont(largeFont)
        love.graphics.setColor(255 / 255, 50 / 255, 100 / 255, 255)
        love.graphics.printf("You lost your last hand!", 50, 50, VIRTUAL_WIDTH, 'center')
    end

    push:finish()
end

function love.update(dt)

    love.keyboard.keysPressed = {}


    if gameState == 'play' then


        if cardValue == 1 then
            cardValue = twoClubs
            pointTotal = pointTotal + 2
        elseif cardValue == 2 then
            cardValue = twoDiamonds
            pointTotal = pointTotal + 2
        elseif cardValue == 3 then
            cardValue = twoHearts
            pointTotal = pointTotal + 2
        elseif cardValue == 4 then
            cardValue = twoSpades
            pointTotal = pointTotal + 2
        elseif cardValue == 5 then
            cardValue = threeClubs
            pointTotal = pointTotal + 3
        elseif cardValue == 6 then
            cardValue = threeDiamonds
            pointTotal = pointTotal + 3
        elseif cardValue == 7 then
            cardValue = threeHearts
            pointTotal = pointTotal + 3
        elseif cardValue == 8 then
            cardValue = threeSpades
            pointTotal = pointTotal + 3
        elseif cardValue == 9 then
            cardValue = fourClubs
            pointTotal = pointTotal + 4
        elseif cardValue == 10 then
            cardValue = fourDiamonds
            pointTotal = pointTotal + 4
        elseif cardValue == 11 then
            cardValue = fourHearts
            pointTotal = pointTotal + 4
        elseif cardValue == 12 then
            cardValue = fourSpades
            pointTotal = pointTotal + 4
        elseif cardValue == 13 then
            cardValue = fiveClubs
            pointTotal = pointTotal + 5
        elseif cardValue == 14 then
            cardValue = fiveDiamonds
            pointTotal = pointTotal + 5
        elseif cardValue == 15 then
            cardValue = fiveHearts
            pointTotal = pointTotal + 5
        elseif cardValue == 16 then
            cardValue = fiveSpades
            pointTotal = pointTotal + 5
        elseif cardValue == 17 then
            cardValue = sixClubs
            pointTotal = pointTotal + 6
        elseif cardValue == 18 then
            cardValue = sixDiamonds
            pointTotal = pointTotal + 6
        elseif cardValue == 19 then
            cardValue = sixHearts
            pointTotal = pointTotal + 6
        elseif cardValue == 20 then
            cardValue = sixSpades
            pointTotal = pointTotal + 6
        elseif cardValue == 21 then
            cardValue = sevenClubs
            pointTotal = pointTotal + 7
        elseif cardValue == 22 then
            cardValue = sevenDiamonds
            pointTotal = pointTotal + 7
        elseif cardValue == 23 then
            cardValue = sevenHearts
            pointTotal = pointTotal + 7
        elseif cardValue == 24 then
            cardValue = sevenSpades
            pointTotal = pointTotal + 7
        elseif cardValue == 25 then
            cardValue = eightClubs
            pointTotal = pointTotal + 8
        elseif cardValue == 26 then
            cardValue = eightDiamonds
            pointTotal = pointTotal + 8
        elseif cardValue == 27 then
            cardValue = eightHearts
            pointTotal = pointTotal + 8
        elseif cardValue == 28 then
            cardValue = eightSpades
            pointTotal = pointTotal + 8
        elseif cardValue == 29 then
            cardValue = nineClubs
            pointTotal = pointTotal + 9
        elseif cardValue == 30 then
            cardValue = nineDiamonds
            pointTotal = pointTotal + 9
        elseif cardValue == 31 then
            cardValue = nineHearts
            pointTotal = pointTotal + 9
        elseif cardValue == 32 then
            cardValue = nineSpades
            pointTotal = pointTotal + 9
        elseif cardValue == 33 then
            cardValue = tenClubs
            pointTotal = pointTotal + 10
        elseif cardValue == 34 then
            cardValue = tenDiamonds
            pointTotal = pointTotal + 10
        elseif cardValue == 35 then
            cardValue = tenHearts
            pointTotal = pointTotal + 10
        elseif cardValue == 36 then
            cardValue = tenSpades
            pointTotal = pointTotal + 10
        elseif cardValue == 37 then
            cardValue = aceClubs
            if pointTotal <= 10 then
                pointTotal = pointTotal + 11
            elseif pointTotal > 10 then
                pointTotal = pointTotal + 1
            end
        elseif cardValue == 38 then
            cardValue = aceDiamonds
            if pointTotal <= 10 then
                pointTotal = pointTotal + 11
            elseif pointTotal > 10 then
                pointTotal = pointTotal + 1
            end
        elseif cardValue == 39 then
            cardValue = aceHearts
            if pointTotal <= 10 then
                pointTotal = pointTotal + 11
            elseif pointTotal > 10 then
                pointTotal = pointTotal + 1
            end
        elseif cardValue == 40 then
            cardValue = aceSpades
            if pointTotal <= 10 then
                pointTotal = pointTotal + 11
            elseif pointTotal > 10 then
                pointTotal = pointTotal + 1
            end
        elseif cardValue == 41 then
            cardValue = jackClubs
            pointTotal = pointTotal + 10
        elseif cardValue == 42 then
            cardValue = jackDiamonds
            pointTotal = pointTotal + 10
        elseif cardValue == 43 then
            cardValue = jackHearts
            pointTotal = pointTotal + 10
        elseif cardValue == 44 then
            cardValue = jackSpades
            pointTotal = pointTotal + 10
        elseif cardValue == 45 then
            cardValue = kingClubs
            pointTotal = pointTotal + 10
        elseif cardValue == 46 then
            cardValue = kingDiamonds
            pointTotal = pointTotal + 10
        elseif cardValue == 47 then
            cardValue = kingHearts
            pointTotal = pointTotal + 10
        elseif cardValue == 48 then
            cardValue = kingSpades
            pointTotal = pointTotal + 10
        elseif cardValue == 49 then
            cardValue = queenClubs
            pointTotal = pointTotal + 10
        elseif cardValue == 50 then
            cardValue = queenDiamonds
            pointTotal = pointTotal + 10
        elseif cardValue == 51 then
            cardValue = queenHearts
            pointTotal = pointTotal + 10
        elseif cardValue == 52 then
            cardValue = queenSpades
            pointTotal = pointTotal + 10
        end
        
        if pointTotal == 21 then
            love.event.winhand()
        end

        if pointTotal > 21 then
            love.event.losehand()
        end
        
    end


end

--This function allows the player the make bets from their current balance during the game.
function love.event.bet(amount)
    --This if statement prevents the user from betting money they do not have.
    if playerMoney < amount then
        amount = 0
    end

    playerMoney = playerMoney - amount
    currentBet = currentBet + amount
    return playerMoney, currentBet

end


function love.event.playhand()
    cardValue = math.random(52)
    return cardValue
end

function love.event.winhand()
    playerMoney = (currentBet * 1.5) + playerMoney
    currentBet = 0
    pointTotal = 0
    cardValue = placeHolder
    handState = 'won'
    return playerMoney, currentBet, pointTotal, cardValue, handState
end

function love.event.losehand()
    currentBet = 0
    pointTotal = 0
    cardValue = placeHolder
    handState = 'lost'
    return currentBet, pointTotal, cardValue, handState
end


