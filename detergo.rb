#
#  DETERGO Laundry Detergent Calculator
#
#  This interpreted script written in Ruby approximately calculates the amount of
#  laundry detergent to wash the clothes a person has, given the amount of dirt,
#  how much room is used up upon loading, and the water hardness from the person's 
#  water supply,
#
#  This is themed after some guidelines from Tide on how to choose the right dosage
#  given the amount of laundry you have and how much dirt there is.
#
#  Programmed by Gregory Desrosiers
#
#  Date: May 25, 2017
#  File Name: detergo.rb
#
#  Original Source Code © 2017 Gregory Desrosiers.
#  This source code file is licensed under the MIT License. Please review 
#  the LICENSE file for details.
#

# Constants / Enums

module DirtLevel
    LOW = 1
    MEDIUM = 2
    HIGH = 3
end

module WaterHardness
    LOW = 1
    MEDIUM = 2
    HIGH = 3
end

# Base class for the detergents
class Detergent
    # How much detergent can we add or take out based on soil level
    @@changeInAmountBasedOnSoil = 0.5 
    # How much detergent can we add or take out based on water hardness
    @@changeInAmountBasedOnWaterHardness = 0.2
    
    def initialize(dirtLevel, drumCapacityUse, waterHardness)
        @dirtLevel = dirtLevel
        @drumCapacityUse = drumCapacityUse
        @waterHardness = waterHardness
    end
    
    # Print messages for different errors
    def printComeBackMessage
        puts "Then come back and run the program again."
    end
    
    def printTooLittleLaundryMessage
        puts "The amount of laundry you have for that type of detergent is" +
            " too small. You'll waste water by doing so. Wait until you have " +
            "enough laundry to load up the machine about half of the drum\'s" +
            " size."
    end
    
    def printTooMuchLaundryMessage
        puts "The amount of laundry you have for that type of detergent is" +
            " too big. Your clothes won't be washed effectively. Consider breaking " +
            "the load down into multiple loads, then run this for each " +
            "load accordingly."
    end
    
end

# These three classes are for the different types of detergent
class PodDetergent < Detergent # Based on Tide detergent pods
    private
    def calculateAmountNeededForWashing
        podsNeeded = 1 # Absolute minimum level
            
        if @drumCapacityUse >= 0.5 and @drumCapacityUse <= 0.75
            podsNeeded = 2
        elsif @drumCapacityUse > 0.75
            podsNeeded = 3
        end
        
        puts "Pods needed: " + podsNeeded.to_s
        
        if @dirtLevel == DirtLevel::LOW
            podsNeeded -= @@changeInAmountBasedOnSoil
        elsif @dirtLevel == DirtLevel::HIGH
            podsNeeded += @@changeInAmountBasedOnSoil
        end
            
        if @waterHardness == WaterHardness::LOW
            podsNeeded -= @@changeInAmountBasedOnWaterHardness
        elsif @waterHardness == WaterHardness::HIGH
            podsNeeded += @@changeInAmountBasedOnWaterHardness
        end
        
        if podsNeeded.round == 0
            podsNeeded = 1
        end
        
        return podsNeeded.round
    end
    
    public
    def amountNeededForWashing
        if @drumCapacityUse < 0.25
            printTooLittleLaundryMessage
        elsif @drumCapacityUse > 0.9
            printTooMuchLaundryMessage
        else
            puts "Add " + calculateAmountNeededForWashing.to_s + " pods to your load of laundry in the machine."
        end
    end
end
    
class LiquidDetergent < Detergent # Based on Arm and Hammer liquid detergent
    private
    def calculateAmountNeededForWashing
        liquidLevel = 1
        
        if @drumCapacityUse >= 0.5 and @drumCapacityUse <= 0.75
            liquidLevel = 3
        elsif @drumCapacityUse > 0.75
            liquidLevel = 5
        end
        
        puts "Liquid level: " + liquidLevel.to_s
        
        if @dirtLevel == DirtLevel::LOW
            liquidLevel -= @@changeInAmountBasedOnSoil
        elsif @dirtLevel == DirtLevel::HIGH
            liquidLevel += @@changeInAmountBasedOnSoil
        end
            
        if @waterHardness == WaterHardness::LOW
            liquidLevel -= @@changeInAmountBasedOnWaterHardness
        elsif @waterHardness == WaterHardness::HIGH
            liquidLevel += @@changeInAmountBasedOnWaterHardness
        end
            
        if liquidLevel.round == 0
            liquidLevel = 1
        end
        
        return liquidLevel.round
    end
    
    public
    def amountNeededForWashing
        if @drumCapacityUse < 0.25
            printTooLittleLaundryMessage
        elsif @drumCapacityUse > 0.9
            printTooMuchLaundryMessage
        else
            puts "Fill the measuring cup to bar " + calculateAmountNeededForWashing.to_s + "."
        end
    end
end
    
class PowderDetergent < Detergent # Based on Tide powder detergent
    private
    def calculateAmountNeededForWashing
        powderLevel = 1
        
        if @drumCapacityUse >= 0.5 and @drumCapacityUse <= 0.75
            powderLevel = 3
        elsif @drumCapacityUse > 0.75
            powderLevel = 4
        end
        
        puts "Powder level: " + powderLevel.to_s
        
        if @dirtLevel == DirtLevel::LOW
            powderLevel -= @@changeInAmountBasedOnSoil
        elsif @dirtLevel == DirtLevel::HIGH
            powderLevel += @@changeInAmountBasedOnSoil
        end
            
        if @waterHardness == WaterHardness::LOW
            powderLevel -= @@changeInAmountBasedOnWaterHardness
        elsif @waterHardness == WaterHardness::HIGH
            powderLevel += @@changeInAmountBasedOnWaterHardness
        end
        
        if powderLevel.round == 0
            powderLevel = 1
        end
        
        return powderLevel.round
    end
    
    public
    def amountNeededForWashing
        if @drumCapacityUse < 0.25
            printTooLittleLaundryMessage
        elsif @drumCapacityUse > 0.9
            printTooMuchLaundryMessage
        else
            puts "Fill the powder measuring cup to bar " + calculateAmountNeededForWashing.to_s + "."
        end
    end
end



# Main Method

selectionErrorMessage = "You need to enter either 1, 2 or 3. Please answer again."
drumUseErrorMessage = "Please enter a decimal between 0 and 1."
goodbyeMessages = ["Ciao.", "Come back soon!", "Program\'s here if you need it. Bye.", "See ya!", "Bye!", "Adios."]

# First Output
puts " --  " + " -- -----  --  --\\" + "  --  " + " --"
puts " | \\"+ " |     |   |   |  |" +  " /   "  + " /  \\"
puts " | | " + " --   |    -- |--/" +  " | -\\" + " |  |"
puts " | / "+  "|     |   |   |\\  " + " |  |"  + " \\  /"
puts " --  " + " --   |    -- | \\ "+  " \\-/  "+ " -- \n\n"

puts "Source Code and Design - Gregory Desrosiers \n" +
"University of Waterloo, Software Engineering 2019\n\n\n"

# Program Loop
wantToRunAgain = true
until wantToRunAgain == false
    response = ""
    until response.length == 1 and (response[0] == "Y" or response[0] == "N") do
        response = ""
        
        # How much laundry do you have?
        puts "How much laundry do you have? Enter a decimal corresponding to how much the laundry fills up in the drum."
        drumUse = ""
        until drumUse.is_a? Numeric and drumUse >= 0.00 and drumUse <= 1.00
            drumUse = gets.chomp
            
            if drumUse.length == 0
                puts drumUseErrorMessage
            elsif drumUse !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/ 
                # from https://stackoverflow.com/questions/1034418/determine-if-a-string-is-a-valid-float-value
                puts "This is not a valid decimal. Please enter again."
            else
                drumUse = drumUse.to_f
                if drumUse < 0.00 or drumUse > 1.00
                    puts drumUseErrorMessage
                end
            end
        end
        
        
        # Type of Detergent
        puts "What type of detergent are you using for your load? Enter 1 for pods, 2 for liquid, and 3 for powder."
        typeOfDetergent = ""
        until typeOfDetergent.length == 1 and (typeOfDetergent == "1" or typeOfDetergent == "2" or typeOfDetergent == "3") do
            typeOfDetergent = gets.chomp
            
            if typeOfDetergent.length != 1 or typeOfDetergent != "1" and typeOfDetergent != "2" and typeOfDetergent != "3"
                puts selectionErrorMessage
            end
            
        end
        
        # Dirt level
        puts "How much dirt is in your clothes? Enter 1 for not much, 2 for some, and 3 for a lot."
        dirtLevel = ""
        until dirtLevel.length == 1 and (dirtLevel == "1" or dirtLevel == "2" or dirtLevel == "3") do
            dirtLevel = gets.chomp
            
            if dirtLevel.length != 1 or dirtLevel != "1" and dirtLevel != "2" and dirtLevel != "3"
                puts selectionErrorMessage
            end
            
        end
            
        # Water hardness level
        puts "What\'s the hardness level of your water supply? Enter 1 for low, 2 for medium, and 3 for high."
        waterHardnessLevel = ""
        until waterHardnessLevel.length == 1 and (waterHardnessLevel == "1" or waterHardnessLevel == "2" or waterHardnessLevel == "3") do
            waterHardnessLevel = gets.chomp
            
            if waterHardnessLevel.length != 1 or waterHardnessLevel != "1" and waterHardnessLevel != "2" and waterHardnessLevel != "3"
                puts selectionErrorMessage
            end
            
        end    
        
        
        
        # Find amount of laundry detergent needed
        if dirtLevel == "1"
            dirtLevel = DirtLevel::LOW
        elsif dirtLevel == "2"
            dirtLevel = DirtLevel::MEDIUM
        else
            dirtLevel = DirtLevel::HIGH
        end
        
        if waterHardnessLevel == "1"
            waterHardnessLevel = WaterHardness::LOW
        elsif waterHardnessLevel == "2"
            waterHardnessLevel = WaterHardness::MEDIUM
        else
            waterHardnessLevel = WaterHardness::HIGH
        end
        
        if typeOfDetergent == "1"
            detergent = PodDetergent.new(dirtLevel, drumUse, waterHardnessLevel)
        elsif typeOfDetergent == "2"
            detergent = LiquidDetergent.new(dirtLevel, drumUse, waterHardnessLevel)
        else
            detergent = PowderDetergent.new(dirtLevel, drumUse, waterHardnessLevel)
        end
        
        detergent.amountNeededForWashing
        
        until response.length == 1 and (response[0] == "Y" or response[0] == "N") do
            puts "Do you want to run this again? Enter Y or N."
            response = gets.chomp
        
            if response.length != 1 or response[0] != "Y" and response[0] != "N"
                puts "You need to enter either a Y or an N. Please answer again."
            end
        end
    end

    if response[0] == "N"
        wantToRunAgain = false
    end
end

# Last Output
puts goodbyeMessages[rand(goodbyeMessages.length)]