WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

--Calls from the push library.
push = require 'push'
Class = require 'class'

stageCounter = 0



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

dealerTotal = 0

playerCard1 = love.graphics.newImage('cards/red_back.png')
playerCard2 = love.graphics.newImage('cards/red_back.png')

dealerCard1 =  love.graphics.newImage('cards/red_back.png')
dealerCard2 = love.graphics.newImage('cards/red_back.png')
dealerCard3 = love.graphics.newImage('cards/red_back.png')
dealerCard4 = love.graphics.newImage('cards/red_back.png')
dealerCard5 = love.graphics.newImage('cards/red_back.png')

placeHolder = love.graphics.newImage('cards/red_back.png')



function love.load()

    math.randomseed(os.time())

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
    if key == 'm' then
        love.event.stageCounter()
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
        love.graphics.printf("Dealer Point Total:", 50, 350, VIRTUAL_WIDTH, 'left')
        love.graphics.print(dealerTotal, 50, 400)

        love.graphics.setFont(gameFont)
        love.graphics.printf("Player Hand:", 450, 100, VIRTUAL_WIDTH)

        love.graphics.printf("Dealer Hand:", 450, 400, VIRTUAL_WIDTH)
        
        love.graphics.scale(0.2,0.2)
        love.graphics.draw(playerCard1, 500/0.2, 175/0.2)
        love.graphics.draw(playerCard2, 650/0.2, 175/0.2)
        love.graphics.draw(dealerCard1, 500/0.2, 475/0.2)
        love.graphics.draw(dealerCard2, 650/0.2, 475/0.2)
        love.graphics.draw(dealerCard3, 800/0.2, 475/0.2)
        love.graphics.draw(dealerCard4, 950/0.2, 475/0.2)
        love.graphics.draw(dealerCard5, 1100/0.2, 475/0.2)



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

function love.event.stageCounter()
    stageCounter = stageCounter + 1
    if stageCounter == 1 then
        love.event.playHandStageOne(playerCard1)
    elseif stageCounter == 2 then
        love.event.playHandStageTwo(playerCard2)
    elseif stageCounter == 3 then
        love.event.dealerHandStageOne(dealerCard1)
    elseif stageCounter == 4 then
        love.event.dealerHandStageTwo(dealerCard2)
    elseif stageCounter == 5 then
        love.event.dealerHandStageThree(dealerCard3)
    elseif stageCounter == 6 then
        love.event.dealerHandStageFour(dealerCard4)
    elseif stageCounter == 7 then
        love.event.dealerHandStageFive(dealerCard5)
    end
    return stageCounter
end


function love.event.playHandStageOne(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        playerCard1 = twoClubs
        pointTotal = pointTotal + 2
    elseif playerCard == 2 then
        playerCard1 = twoDiamonds
        pointTotal = pointTotal + 2
    elseif playerCard == 3 then
        playerCard1 = twoHearts
        pointTotal = pointTotal + 2
    elseif playerCard == 4 then
        playerCard1 = twoSpades
        pointTotal = pointTotal + 2
    elseif playerCard == 5 then
        playerCard1 = threeClubs
        pointTotal = pointTotal + 3
    elseif playerCard == 6 then
        playerCard1 = threeDiamonds
        pointTotal = pointTotal + 3
    elseif playerCard == 7 then
        playerCard1 = threeHearts
        pointTotal = pointTotal + 3
    elseif playerCard == 8 then
        playerCard1 = threeSpades
        pointTotal = pointTotal + 3
    elseif playerCard == 9 then
        playerCard1 = fourClubs
        pointTotal = pointTotal + 4
    elseif playerCard == 10 then
        playerCard1 = fourDiamonds
        pointTotal = pointTotal + 4
    elseif playerCard == 11 then
        playerCard1 = fourHearts
        pointTotal = pointTotal + 4
    elseif playerCard == 12 then
        playerCard1 = fourSpades
        pointTotal = pointTotal + 4
    elseif playerCard == 13 then
        playerCard1 = fiveClubs
        pointTotal = pointTotal + 5
    elseif playerCard == 14 then
        playerCard1 = fiveDiamonds
        pointTotal = pointTotal + 5
    elseif playerCard == 15 then
        playerCard1 = fiveHearts
        pointTotal = pointTotal + 5
    elseif playerCard == 16 then
        playerCard1 = fiveSpades
        pointTotal = pointTotal + 5
    elseif playerCard == 17 then
        playerCard1 = sixClubs
        pointTotal = pointTotal + 6
    elseif playerCard == 18 then
        playerCard1 = sixDiamonds
        pointTotal = pointTotal + 6
    elseif playerCard == 19 then
        playerCard1 = sixHearts
        pointTotal = pointTotal + 6
    elseif playerCard == 20 then
        playerCard1 = sixSpades
        pointTotal = pointTotal + 6
    elseif playerCard == 21 then
        playerCard1 = sevenClubs
        pointTotal = pointTotal + 7
    elseif playerCard == 22 then
        playerCard1 = sevenDiamonds
        pointTotal = pointTotal + 7
    elseif playerCard == 23 then
        playerCard1 = sevenHearts
        pointTotal = pointTotal + 7
    elseif playerCard == 24 then
        playerCard1 = sevenSpades
        pointTotal = pointTotal + 7
    elseif playerCard == 25 then
        playerCard1 = eightClubs
        pointTotal = pointTotal + 8
    elseif playerCard == 26 then
        playerCard1 = eightDiamonds
        pointTotal = pointTotal + 8
    elseif playerCard == 27 then
        playerCard1 = eightHearts
        pointTotal = pointTotal + 8
    elseif playerCard == 28 then
        playerCard1 = eightSpades
        pointTotal = pointTotal + 8
    elseif playerCard == 29 then
        playerCard1 = nineClubs
        pointTotal = pointTotal + 9
    elseif playerCard == 30 then
        playerCard1 = nineDiamonds
        pointTotal = pointTotal + 9
    elseif playerCard == 31 then
        playerCard1 = nineHearts
        pointTotal = pointTotal + 9
    elseif playerCard == 32 then
        playerCard1 = nineSpades
        pointTotal = pointTotal + 9
    elseif playerCard == 33 then
        playerCard1 = tenClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 34 then
        playerCard1 = tenDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 35 then
        playerCard1 = tenHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 36 then
        playerCard1 = tenSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 37 then
        playerCard1 = aceClubs
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 38 then
        playerCard1 = aceDiamonds
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 39 then
        playerCard1 = aceHearts
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 40 then
        playerCard1 = aceSpades
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 41 then
        playerCard1 = jackClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 42 then
        playerCard1 = jackDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 43 then
        playerCard1 = jackHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 44 then
        playerCard1 = jackSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 45 then
        playerCard1 = kingClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 46 then
        playerCard1 = kingDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 47 then
        playerCard1 = kingHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 48 then
        playerCard1 = kingSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 49 then
        playerCard1 = queenClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 50 then
        playerCard1 = queenDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 51 then
        playerCard1 = queenHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 52 then
        playerCard1 = queenSpades
        pointTotal = pointTotal + 10
    end
    return playerCard1, pointTotal
end

function love.event.playHandStageTwo(playerCard)

    playerCard = math.random(52)

    if playerCard == 1 then
        playerCard2 = twoClubs
        pointTotal = pointTotal + 2
    elseif playerCard == 2 then
        playerCard2 = twoDiamonds
        pointTotal = pointTotal + 2
    elseif playerCard == 3 then
        playerCard2 = twoHearts
        pointTotal = pointTotal + 2
    elseif playerCard == 4 then
        playerCard2 = twoSpades
        pointTotal = pointTotal + 2
    elseif playerCard == 5 then
        playerCard2 = threeClubs
        pointTotal = pointTotal + 3
    elseif playerCard == 6 then
        playerCard2 = threeDiamonds
        pointTotal = pointTotal + 3
    elseif playerCard == 7 then
        playerCard2 = threeHearts
        pointTotal = pointTotal + 3
    elseif playerCard == 8 then
        playerCard2 = threeSpades
        pointTotal = pointTotal + 3
    elseif playerCard == 9 then
        playerCard2 = fourClubs
        pointTotal = pointTotal + 4
    elseif playerCard == 10 then
        playerCard2 = fourDiamonds
        pointTotal = pointTotal + 4
    elseif playerCard == 11 then
        playerCard2 = fourHearts
        pointTotal = pointTotal + 4
    elseif playerCard == 12 then
        playerCard2 = fourSpades
        pointTotal = pointTotal + 4
    elseif playerCard == 13 then
        playerCard2 = fiveClubs
        pointTotal = pointTotal + 5
    elseif playerCard == 14 then
        playerCard2 = fiveDiamonds
        pointTotal = pointTotal + 5
    elseif playerCard == 15 then
        playerCard2 = fiveHearts
        pointTotal = pointTotal + 5
    elseif playerCard == 16 then
        playerCard2 = fiveSpades
        pointTotal = pointTotal + 5
    elseif playerCard == 17 then
        playerCard2 = sixClubs
        pointTotal = pointTotal + 6
    elseif playerCard == 18 then
        playerCard2 = sixDiamonds
        pointTotal = pointTotal + 6
    elseif playerCard == 19 then
        playerCard2 = sixHearts
        pointTotal = pointTotal + 6
    elseif playerCard == 20 then
        playerCard2 = sixSpades
        pointTotal = pointTotal + 6
    elseif playerCard == 21 then
        playerCard2 = sevenClubs
        pointTotal = pointTotal + 7
    elseif playerCard == 22 then
        playerCard2 = sevenDiamonds
        pointTotal = pointTotal + 7
    elseif playerCard == 23 then
        playerCard2 = sevenHearts
        pointTotal = pointTotal + 7
    elseif playerCard == 24 then
        playerCard2 = sevenSpades
        pointTotal = pointTotal + 7
    elseif playerCard == 25 then
        playerCard2 = eightClubs
        pointTotal = pointTotal + 8
    elseif playerCard == 26 then
        playerCard2 = eightDiamonds
        pointTotal = pointTotal + 8
    elseif playerCard == 27 then
        playerCard2 = eightHearts
        pointTotal = pointTotal + 8
    elseif playerCard == 28 then
        playerCard2 = eightSpades
        pointTotal = pointTotal + 8
    elseif playerCard == 29 then
        playerCard2 = nineClubs
        pointTotal = pointTotal + 9
    elseif playerCard == 30 then
        playerCard2 = nineDiamonds
        pointTotal = pointTotal + 9
    elseif playerCard == 31 then
        playerCard2 = nineHearts
        pointTotal = pointTotal + 9
    elseif playerCard == 32 then
        playerCard2 = nineSpades
        pointTotal = pointTotal + 9
    elseif playerCard == 33 then
        playerCard2 = tenClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 34 then
        playerCard2 = tenDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 35 then
        playerCard2 = tenHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 36 then
        playerCard2 = tenSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 37 then
        playerCard2 = aceClubs
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 38 then
        playerCard2 = aceDiamonds
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 39 then
        playerCard2 = aceHearts
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 40 then
        playerCard2 = aceSpades
        if pointTotal <= 10 then
            pointTotal = pointTotal + 11
        elseif pointTotal > 10 then
            pointTotal = pointTotal + 1
        end
    elseif playerCard == 41 then
        playerCard2 = jackClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 42 then
        playerCard2 = jackDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 43 then
        playerCard2 = jackHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 44 then
        playerCard2 = jackSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 45 then
        playerCard2 = kingClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 46 then
        playerCard2 = kingDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 47 then
        playerCard2 = kingHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 48 then
        playerCard2 = kingSpades
        pointTotal = pointTotal + 10
    elseif playerCard == 49 then
        playerCard2 = queenClubs
        pointTotal = pointTotal + 10
    elseif playerCard == 50 then
        playerCard2 = queenDiamonds
        pointTotal = pointTotal + 10
    elseif playerCard == 51 then
        playerCard2 = queenHearts
        pointTotal = pointTotal + 10
    elseif playerCard == 52 then
        playerCard2 = queenSpades
        pointTotal = pointTotal + 10
    end
    return playerCard2, pointTotal
end

function love.event.dealerHandStageOne(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        dealerCard1 = twoClubs
        dealerTotal = dealerTotal + 2
    elseif playerCard == 2 then
        dealerCard1 = twoDiamonds
        dealerTotal = dealerTotal + 2
    elseif playerCard == 3 then
        dealerCard1 = twoHearts
        dealerTotal = dealerTotal + 2
    elseif playerCard == 4 then
        dealerCard1 = twoSpades
        dealerTotal = dealerTotal + 2
    elseif playerCard == 5 then
        dealerCard1 = threeClubs
        dealerTotal = dealerTotal + 3
    elseif playerCard == 6 then
        dealerCard1 = threeDiamonds
        dealerTotal = dealerTotal + 3
    elseif playerCard == 7 then
        dealerCard1 = threeHearts
        dealerTotal = dealerTotal + 3
    elseif playerCard == 8 then
        dealerCard1 = threeSpades
        dealerTotal = dealerTotal + 3
    elseif playerCard == 9 then
        dealerCard1 = fourClubs
        dealerTotal = dealerTotal + 4
    elseif playerCard == 10 then
        dealerCard1 = fourDiamonds
        dealerTotal = dealerTotal + 4
    elseif playerCard == 11 then
        dealerCard1 = fourHearts
        dealerTotal = dealerTotal + 4
    elseif playerCard == 12 then
        dealerCard1 = fourSpades
        dealerTotal = dealerTotal + 4
    elseif playerCard == 13 then
        dealerCard1 = fiveClubs
        dealerTotal = dealerTotal + 5
    elseif playerCard == 14 then
        dealerCard1 = fiveDiamonds
        dealerTotal = dealerTotal + 5
    elseif playerCard == 15 then
        dealerCard1 = fiveHearts
        dealerTotal = dealerTotal + 5
    elseif playerCard == 16 then
        dealerCard1 = fiveSpades
        dealerTotal = dealerTotal + 5
    elseif playerCard == 17 then
        dealerCard1 = sixClubs
        dealerTotal = dealerTotal + 6
    elseif playerCard == 18 then
        dealerCard1 = sixDiamonds
        dealerTotal = dealerTotal + 6
    elseif playerCard == 19 then
        dealerCard1 = sixHearts
        dealerTotal = dealerTotal + 6
    elseif playerCard == 20 then
        dealerCard1 = sixSpades
        dealerTotal = dealerTotal + 6
    elseif playerCard == 21 then
        dealerCard1 = sevenClubs
        dealerTotal = dealerTotal + 7
    elseif playerCard == 22 then
        dealerCard1 = sevenDiamonds
        dealerTotal = dealerTotal + 7
    elseif playerCard == 23 then
        dealerCard1 = sevenHearts
        dealerTotal = dealerTotal + 7
    elseif playerCard == 24 then
        dealerCard1 = sevenSpades
        dealerTotal = dealerTotal + 7
    elseif playerCard == 25 then
        dealerCard1 = eightClubs
        dealerTotal = dealerTotal + 8
    elseif playerCard == 26 then
        dealerCard1 = eightDiamonds
        dealerTotal = dealerTotal + 8
    elseif playerCard == 27 then
        dealerCard1 = eightHearts
        dealerTotal = dealerTotal + 8
    elseif playerCard == 28 then
        dealerCard1 = eightSpades
        dealerTotal = dealerTotal + 8
    elseif playerCard == 29 then
        dealerCard1 = nineClubs
        dealerTotal = dealerTotal + 9
    elseif playerCard == 30 then
        dealerCard1 = nineDiamonds
        dealerTotal = dealerTotal + 9
    elseif playerCard == 31 then
        dealerCard1 = nineHearts
        dealerTotal = dealerTotal + 9
    elseif playerCard == 32 then
        dealerCard1 = nineSpades
        dealerTotal = dealerTotal + 9
    elseif playerCard == 33 then
        dealerCard1 = tenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 34 then
        dealerCard1 = tenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 35 then
        dealerCard1 = tenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 36 then
        dealerCard1 = tenSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 37 then
        dealerCard1 = aceClubs
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 38 then
        dealerCard1 = aceDiamonds
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 39 then
        dealerCard1 = aceHearts
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 40 then
        dealerCard1 = aceSpades
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 41 then
        dealerCard1 = jackClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 42 then
        dealerCard1 = jackDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 43 then
        dealerCard1 = jackHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 44 then
        dealerCard1 = jackSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 45 then
        dealerCard1 = kingClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 46 then
        dealerCard1 = kingDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 47 then
        dealerCard1 = kingHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 48 then
        dealerCard1 = kingSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 49 then
        dealerCard1 = queenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 50 then
        dealerCard1 = queenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 51 then
        dealerCard1 = queenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 52 then
        dealerCard1 = queenSpades
        dealerTotal = dealerTotal + 10
    end
    return dealerCard1, dealerTotal
end

function love.event.dealerHandStageTwo(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        dealerCard2 = twoClubs
        dealerTotal = dealerTotal + 2
    elseif playerCard == 2 then
        dealerCard2 = twoDiamonds
        dealerTotal = dealerTotal + 2
    elseif playerCard == 3 then
        dealerCard2 = twoHearts
        dealerTotal = dealerTotal + 2
    elseif playerCard == 4 then
        dealerCard2 = twoSpades
        dealerTotal = dealerTotal + 2
    elseif playerCard == 5 then
        dealerCard2 = threeClubs
        dealerTotal = dealerTotal + 3
    elseif playerCard == 6 then
        dealerCard2 = threeDiamonds
        dealerTotal = dealerTotal + 3
    elseif playerCard == 7 then
        dealerCard2 = threeHearts
        dealerTotal = dealerTotal + 3
    elseif playerCard == 8 then
        dealerCard2 = threeSpades
        dealerTotal = dealerTotal + 3
    elseif playerCard == 9 then
        dealerCard2 = fourClubs
        dealerTotal = dealerTotal + 4
    elseif playerCard == 10 then
        dealerCard2 = fourDiamonds
        dealerTotal = dealerTotal + 4
    elseif playerCard == 11 then
        dealerCard2 = fourHearts
        dealerTotal = dealerTotal + 4
    elseif playerCard == 12 then
        dealerCard2 = fourSpades
        dealerTotal = dealerTotal + 4
    elseif playerCard == 13 then
        dealerCard2 = fiveClubs
        dealerTotal = dealerTotal + 5
    elseif playerCard == 14 then
        dealerCard2 = fiveDiamonds
        dealerTotal = dealerTotal + 5
    elseif playerCard == 15 then
        dealerCard2 = fiveHearts
        dealerTotal = dealerTotal + 5
    elseif playerCard == 16 then
        dealerCard2 = fiveSpades
        dealerTotal = dealerTotal + 5
    elseif playerCard == 17 then
        dealerCard2 = sixClubs
        dealerTotal = dealerTotal + 6
    elseif playerCard == 18 then
        dealerCard2 = sixDiamonds
        dealerTotal = dealerTotal + 6
    elseif playerCard == 19 then
        dealerCard2 = sixHearts
        dealerTotal = dealerTotal + 6
    elseif playerCard == 20 then
        dealerCard2 = sixSpades
        dealerTotal = dealerTotal + 6
    elseif playerCard == 21 then
        dealerCard2 = sevenClubs
        dealerTotal = dealerTotal + 7
    elseif playerCard == 22 then
        dealerCard2 = sevenDiamonds
        dealerTotal = dealerTotal + 7
    elseif playerCard == 23 then
        dealerCard2 = sevenHearts
        dealerTotal = dealerTotal + 7
    elseif playerCard == 24 then
        dealerCard2 = sevenSpades
        dealerTotal = dealerTotal + 7
    elseif playerCard == 25 then
        dealerCard2 = eightClubs
        dealerTotal = dealerTotal + 8
    elseif playerCard == 26 then
        dealerCard2 = eightDiamonds
        dealerTotal = dealerTotal + 8
    elseif playerCard == 27 then
        dealerCard2 = eightHearts
        dealerTotal = dealerTotal + 8
    elseif playerCard == 28 then
        dealerCard2 = eightSpades
        dealerTotal = dealerTotal + 8
    elseif playerCard == 29 then
        dealerCard2 = nineClubs
        dealerTotal = dealerTotal + 9
    elseif playerCard == 30 then
        dealerCard2 = nineDiamonds
        dealerTotal = dealerTotal + 9
    elseif playerCard == 31 then
        dealerCard2 = nineHearts
        dealerTotal = dealerTotal + 9
    elseif playerCard == 32 then
        dealerCard2 = nineSpades
        dealerTotal = dealerTotal + 9
    elseif playerCard == 33 then
        dealerCard2 = tenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 34 then
        dealerCard2 = tenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 35 then
        dealerCard2 = tenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 36 then
        dealerCard2 = tenSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 37 then
        dealerCard2 = aceClubs
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 38 then
        dealerCard2 = aceDiamonds
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 39 then
        dealerCard2 = aceHearts
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 40 then
        dealerCard2 = aceSpades
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 41 then
        dealerCard2 = jackClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 42 then
        dealerCard2 = jackDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 43 then
        dealerCard2 = jackHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 44 then
        dealerCard2 = jackSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 45 then
        dealerCard2 = kingClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 46 then
        dealerCard2 = kingDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 47 then
        dealerCard2 = kingHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 48 then
        dealerCard2 = kingSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 49 then
        dealerCard2 = queenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 50 then
        dealerCard2 = queenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 51 then
        dealerCard2 = queenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 52 then
        dealerCard2 = queenSpades
        dealerTotal = dealerTotal + 10
    end
    return dealerCard2, dealerTotal
end

function love.event.dealerHandStageThree(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        dealerCard3 = twoClubs
        dealerTotal = dealerTotal + 2
    elseif playerCard == 2 then
        dealerCard3 = twoDiamonds
        dealerTotal = dealerTotal + 2
    elseif playerCard == 3 then
        dealerCard3 = twoHearts
        dealerTotal = dealerTotal + 2
    elseif playerCard == 4 then
        dealerCard3 = twoSpades
        dealerTotal = dealerTotal + 2
    elseif playerCard == 5 then
        dealerCard3 = threeClubs
        dealerTotal = dealerTotal + 3
    elseif playerCard == 6 then
        dealerCard3 = threeDiamonds
        dealerTotal = dealerTotal + 3
    elseif playerCard == 7 then
        dealerCard3 = threeHearts
        dealerTotal = dealerTotal + 3
    elseif playerCard == 8 then
        dealerCard3 = threeSpades
        dealerTotal = dealerTotal + 3
    elseif playerCard == 9 then
        dealerCard3 = fourClubs
        dealerTotal = dealerTotal + 4
    elseif playerCard == 10 then
        dealerCard3 = fourDiamonds
        dealerTotal = dealerTotal + 4
    elseif playerCard == 11 then
        dealerCard3 = fourHearts
        dealerTotal = dealerTotal + 4
    elseif playerCard == 12 then
        dealerCard3 = fourSpades
        dealerTotal = dealerTotal + 4
    elseif playerCard == 13 then
        dealerCard3 = fiveClubs
        dealerTotal = dealerTotal + 5
    elseif playerCard == 14 then
        dealerCard3 = fiveDiamonds
        dealerTotal = dealerTotal + 5
    elseif playerCard == 15 then
        dealerCard3 = fiveHearts
        dealerTotal = dealerTotal + 5
    elseif playerCard == 16 then
        dealerCard3 = fiveSpades
        dealerTotal = dealerTotal + 5
    elseif playerCard == 17 then
        dealerCard3 = sixClubs
        dealerTotal = dealerTotal + 6
    elseif playerCard == 18 then
        dealerCard3 = sixDiamonds
        dealerTotal = dealerTotal + 6
    elseif playerCard == 19 then
        dealerCard3 = sixHearts
        dealerTotal = dealerTotal + 6
    elseif playerCard == 20 then
        dealerCard3 = sixSpades
        dealerTotal = dealerTotal + 6
    elseif playerCard == 21 then
        dealerCard3 = sevenClubs
        dealerTotal = dealerTotal + 7
    elseif playerCard == 22 then
        dealerCard3 = sevenDiamonds
        dealerTotal = dealerTotal + 7
    elseif playerCard == 23 then
        dealerCard3 = sevenHearts
        dealerTotal = dealerTotal + 7
    elseif playerCard == 24 then
        dealerCard3 = sevenSpades
        dealerTotal = dealerTotal + 7
    elseif playerCard == 25 then
        dealerCard3 = eightClubs
        dealerTotal = dealerTotal + 8
    elseif playerCard == 26 then
        dealerCard3 = eightDiamonds
        dealerTotal = dealerTotal + 8
    elseif playerCard == 27 then
        dealerCard3 = eightHearts
        dealerTotal = dealerTotal + 8
    elseif playerCard == 28 then
        dealerCard3 = eightSpades
        dealerTotal = dealerTotal + 8
    elseif playerCard == 29 then
        dealerCard3 = nineClubs
        dealerTotal = dealerTotal + 9
    elseif playerCard == 30 then
        dealerCard3 = nineDiamonds
        dealerTotal = dealerTotal + 9
    elseif playerCard == 31 then
        dealerCard3 = nineHearts
        dealerTotal = dealerTotal + 9
    elseif playerCard == 32 then
        dealerCard3 = nineSpades
        dealerTotal = dealerTotal + 9
    elseif playerCard == 33 then
        dealerCard3 = tenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 34 then
        dealerCard3 = tenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 35 then
        dealerCard3 = tenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 36 then
        dealerCard3 = tenSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 37 then
        dealerCard3 = aceClubs
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 38 then
        dealerCard3 = aceDiamonds
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 39 then
        dealerCard3 = aceHearts
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 40 then
        dealerCard3 = aceSpades
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 41 then
        dealerCard3 = jackClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 42 then
        dealerCard3 = jackDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 43 then
        dealerCard3 = jackHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 44 then
        dealerCard3 = jackSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 45 then
        dealerCard3 = kingClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 46 then
        dealerCard3 = kingDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 47 then
        dealerCard3 = kingHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 48 then
        dealerCard3 = kingSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 49 then
        dealerCard3 = queenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 50 then
        dealerCard3 = queenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 51 then
        dealerCard3 = queenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 52 then
        dealerCard3 = queenSpades
        dealerTotal = dealerTotal + 10
    end
    return dealerCard3, dealerTotal
end

function love.event.dealerHandStageFour(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        dealerCard4 = twoClubs
        dealerTotal = dealerTotal + 2
    elseif playerCard == 2 then
        dealerCard4 = twoDiamonds
        dealerTotal = dealerTotal + 2
    elseif playerCard == 3 then
        dealerCard4 = twoHearts
        dealerTotal = dealerTotal + 2
    elseif playerCard == 4 then
        dealerCard4 = twoSpades
        dealerTotal = dealerTotal + 2
    elseif playerCard == 5 then
        dealerCard4 = threeClubs
        dealerTotal = dealerTotal + 3
    elseif playerCard == 6 then
        dealerCard4 = threeDiamonds
        dealerTotal = dealerTotal + 3
    elseif playerCard == 7 then
        dealerCard4 = threeHearts
        dealerTotal = dealerTotal + 3
    elseif playerCard == 8 then
        dealerCard4 = threeSpades
        dealerTotal = dealerTotal + 3
    elseif playerCard == 9 then
        dealerCard4 = fourClubs
        dealerTotal = dealerTotal + 4
    elseif playerCard == 10 then
        dealerCard4 = fourDiamonds
        dealerTotal = dealerTotal + 4
    elseif playerCard == 11 then
        dealerCard4 = fourHearts
        dealerTotal = dealerTotal + 4
    elseif playerCard == 12 then
        dealerCard4 = fourSpades
        dealerTotal = dealerTotal + 4
    elseif playerCard == 13 then
        dealerCard4 = fiveClubs
        dealerTotal = dealerTotal + 5
    elseif playerCard == 14 then
        dealerCard4 = fiveDiamonds
        dealerTotal = dealerTotal + 5
    elseif playerCard == 15 then
        dealerCard4 = fiveHearts
        dealerTotal = dealerTotal + 5
    elseif playerCard == 16 then
        dealerCard4 = fiveSpades
        dealerTotal = dealerTotal + 5
    elseif playerCard == 17 then
        dealerCard4 = sixClubs
        dealerTotal = dealerTotal + 6
    elseif playerCard == 18 then
        dealerCard4 = sixDiamonds
        dealerTotal = dealerTotal + 6
    elseif playerCard == 19 then
        dealerCard4 = sixHearts
        dealerTotal = dealerTotal + 6
    elseif playerCard == 20 then
        dealerCard4 = sixSpades
        dealerTotal = dealerTotal + 6
    elseif playerCard == 21 then
        dealerCard4 = sevenClubs
        dealerTotal = dealerTotal + 7
    elseif playerCard == 22 then
        dealerCard4 = sevenDiamonds
        dealerTotal = dealerTotal + 7
    elseif playerCard == 23 then
        dealerCard4 = sevenHearts
        dealerTotal = dealerTotal + 7
    elseif playerCard == 24 then
        dealerCard4 = sevenSpades
        dealerTotal = dealerTotal + 7
    elseif playerCard == 25 then
        dealerCard4 = eightClubs
        dealerTotal = dealerTotal + 8
    elseif playerCard == 26 then
        dealerCard4 = eightDiamonds
        dealerTotal = dealerTotal + 8
    elseif playerCard == 27 then
        dealerCard4 = eightHearts
        dealerTotal = dealerTotal + 8
    elseif playerCard == 28 then
        dealerCard4 = eightSpades
        dealerTotal = dealerTotal + 8
    elseif playerCard == 29 then
        dealerCard4 = nineClubs
        dealerTotal = dealerTotal + 9
    elseif playerCard == 30 then
        dealerCard4 = nineDiamonds
        dealerTotal = dealerTotal + 9
    elseif playerCard == 31 then
        dealerCard4 = nineHearts
        dealerTotal = dealerTotal + 9
    elseif playerCard == 32 then
        dealerCard4 = nineSpades
        dealerTotal = dealerTotal + 9
    elseif playerCard == 33 then
        dealerCard4 = tenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 34 then
        dealerCard4 = tenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 35 then
        dealerCard4 = tenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 36 then
        dealerCard4 = tenSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 37 then
        dealerCard4 = aceClubs
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 38 then
        dealerCard4 = aceDiamonds
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 39 then
        dealerCard4 = aceHearts
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 40 then
        dealerCard4 = aceSpades
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 41 then
        dealerCard4 = jackClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 42 then
        dealerCard4 = jackDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 43 then
        dealerCard4 = jackHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 44 then
        dealerCard4 = jackSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 45 then
        dealerCard4 = kingClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 46 then
        dealerCard4 = kingDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 47 then
        dealerCard4 = kingHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 48 then
        dealerCard4 = kingSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 49 then
        dealerCard4 = queenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 50 then
        dealerCard4 = queenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 51 then
        dealerCard4 = queenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 52 then
        dealerCard4 = queenSpades
        dealerTotal = dealerTotal + 10
    end
    return dealerCard4, dealerTotal
end

function love.event.dealerHandStageFive(playerCard)
    playerCard = math.random(52)

    if playerCard == 1 then
        dealerCard5 = twoClubs
        dealerTotal = dealerTotal + 2
    elseif playerCard == 2 then
        dealerCard5 = twoDiamonds
        dealerTotal = dealerTotal + 2
    elseif playerCard == 3 then
        dealerCard5 = twoHearts
        dealerTotal = dealerTotal + 2
    elseif playerCard == 4 then
        dealerCard5 = twoSpades
        dealerTotal = dealerTotal + 2
    elseif playerCard == 5 then
        dealerCard5 = threeClubs
        dealerTotal = dealerTotal + 3
    elseif playerCard == 6 then
        dealerCard5 = threeDiamonds
        dealerTotal = dealerTotal + 3
    elseif playerCard == 7 then
        dealerCard5 = threeHearts
        dealerTotal = dealerTotal + 3
    elseif playerCard == 8 then
        dealerCard5 = threeSpades
        dealerTotal = dealerTotal + 3
    elseif playerCard == 9 then
        dealerCard5 = fourClubs
        dealerTotal = dealerTotal + 4
    elseif playerCard == 10 then
        dealerCard5 = fourDiamonds
        dealerTotal = dealerTotal + 4
    elseif playerCard == 11 then
        dealerCard5 = fourHearts
        dealerTotal = dealerTotal + 4
    elseif playerCard == 12 then
        dealerCard5 = fourSpades
        dealerTotal = dealerTotal + 4
    elseif playerCard == 13 then
        dealerCard5 = fiveClubs
        dealerTotal = dealerTotal + 5
    elseif playerCard == 14 then
        dealerCard5 = fiveDiamonds
        dealerTotal = dealerTotal + 5
    elseif playerCard == 15 then
        dealerCard5 = fiveHearts
        dealerTotal = dealerTotal + 5
    elseif playerCard == 16 then
        dealerCard5 = fiveSpades
        dealerTotal = dealerTotal + 5
    elseif playerCard == 17 then
        dealerCard5 = sixClubs
        dealerTotal = dealerTotal + 6
    elseif playerCard == 18 then
        dealerCard5 = sixDiamonds
        dealerTotal = dealerTotal + 6
    elseif playerCard == 19 then
        dealerCard5 = sixHearts
        dealerTotal = dealerTotal + 6
    elseif playerCard == 20 then
        dealerCard5 = sixSpades
        dealerTotal = dealerTotal + 6
    elseif playerCard == 21 then
        dealerCard5 = sevenClubs
        dealerTotal = dealerTotal + 7
    elseif playerCard == 22 then
        dealerCard5 = sevenDiamonds
        dealerTotal = dealerTotal + 7
    elseif playerCard == 23 then
        dealerCard5 = sevenHearts
        dealerTotal = dealerTotal + 7
    elseif playerCard == 24 then
        dealerCard5 = sevenSpades
        dealerTotal = dealerTotal + 7
    elseif playerCard == 25 then
        dealerCard5 = eightClubs
        dealerTotal = dealerTotal + 8
    elseif playerCard == 26 then
        dealerCard5 = eightDiamonds
        dealerTotal = dealerTotal + 8
    elseif playerCard == 27 then
        dealerCard5 = eightHearts
        dealerTotal = dealerTotal + 8
    elseif playerCard == 28 then
        dealerCard5 = eightSpades
        dealerTotal = dealerTotal + 8
    elseif playerCard == 29 then
        dealerCard5 = nineClubs
        dealerTotal = dealerTotal + 9
    elseif playerCard == 30 then
        dealerCard5 = nineDiamonds
        dealerTotal = dealerTotal + 9
    elseif playerCard == 31 then
        dealerCard5 = nineHearts
        dealerTotal = dealerTotal + 9
    elseif playerCard == 32 then
        dealerCard5 = nineSpades
        dealerTotal = dealerTotal + 9
    elseif playerCard == 33 then
        dealerCard5 = tenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 34 then
        dealerCard5 = tenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 35 then
        dealerCard5 = tenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 36 then
        dealerCard5 = tenSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 37 then
        dealerCard5 = aceClubs
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 38 then
        dealerCard5 = aceDiamonds
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 39 then
        dealerCard5 = aceHearts
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 40 then
        dealerCard5 = aceSpades
        if dealerTotal <= 10 then
            dealerTotal = dealerTotal + 11
        elseif dealerTotal > 10 then
            dealerTotal = dealerTotal + 1
        end
    elseif playerCard == 41 then
        dealerCard5 = jackClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 42 then
        dealerCard5 = jackDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 43 then
        dealerCard5 = jackHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 44 then
        dealerCard5 = jackSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 45 then
        dealerCard5 = kingClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 46 then
        dealerCard5 = kingDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 47 then
        dealerCard5 = kingHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 48 then
        dealerCard5 = kingSpades
        dealerTotal = dealerTotal + 10
    elseif playerCard == 49 then
        dealerCard5 = queenClubs
        dealerTotal = dealerTotal + 10
    elseif playerCard == 50 then
        dealerCard5 = queenDiamonds
        dealerTotal = dealerTotal + 10
    elseif playerCard == 51 then
        dealerCard5 = queenHearts
        dealerTotal = dealerTotal + 10
    elseif playerCard == 52 then
        dealerCard5 = queenSpades
        dealerTotal = dealerTotal + 10
    end
    return dealerCard5, dealerTotal
end

function love.event.winhand()
    playerMoney = (currentBet * 1.5) + playerMoney
    currentBet = 0
    pointTotal = 0
    dealerTotal = 0
    playerCard1 = placeHolder
    playerCard2 = placeHolder
    dealerCard1 = placeHolder
    dealerCard2 = placeHolder
    dealerCard3 = placeHolder
    dealerCard4 = placeHolder
    dealerCard5 = placeHolder
    stageCounter = 0
    handState = 'won'
    return playerMoney, currentBet, pointTotal, dealerTotal, playerCard1, playerCard2, dealerCard1, dealerCard2, dealerCard3, dealerCard4, dealerCard5, handState, stageCounter
end

function love.event.losehand()
    currentBet = 0
    pointTotal = 0
    dealerTotal = 0
    playerCard1 = placeHolder
    playerCard2 = placeHolder
    dealerCard1 = placeHolder
    dealerCard2 = placeHolder
    dealerCard3 = placeHolder
    dealerCard4 = placeHolder
    dealerCard5 = placeHolder
    stageCounter = 0
    handState = 'lost'
    return currentBet, pointTotal, dealerTotal, playerCard1, playerCard2, dealerCard1, dealerCard2, dealerCard3, dealerCard4, dealerCard5, handState, stageCounter
end


