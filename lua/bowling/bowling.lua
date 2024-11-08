local Bonus = {
  NONE = 0,
  FILL_ROLL_1X = 1,
  FILL_ROLL_1X_1X = 2,
  ROLL_2X = 3,
  ROLL_2X_2X = 4,
  FILL_ROLL_2X_1X = 5,
  ROLL_3X = 6,
  ROLL_3X_2X = 7,
}

return function()
  local score = 0
  local frame = 1
  local frame_pins = nil
  local frame_done = false
  local bonus = 0
  local new_bonus = Bonus.NONE

  return {
    roll = function(pins)
      -- validate can_roll
      local can_roll = frame <= 10
      can_roll = can_roll or (frame == 11 and bonus > Bonus.NONE)
      if not can_roll then return error("Roll Error: Game is finished", 2) end

      -- calculate clean pin count, frame status and new frame bonus
      if frame_pins then
        frame_pins = frame_pins + pins
        if frame_pins == 10 then
          if frame < 10 then
            new_bonus = Bonus.ROLL_2X -- spare
          elseif frame == 10 then
            new_bonus = Bonus.FILL_ROLL_1X
          else
            new_bonus = Bonus.NONE
          end
        end
        frame_done = true
      else
        frame_pins = pins
        if frame_pins == 10 then
          if frame < 10 then
            new_bonus = Bonus.ROLL_2X_2X -- strike
            frame_done = true
          elseif frame == 10 then
            new_bonus = Bonus.FILL_ROLL_1X_1X
            frame_done = true
          else
            new_bonus = Bonus.NONE
            frame_pins = 0
          end
        end
      end

      -- validate_frame_pins
      if pins < 0 then return error("Roll Error: Negative pin count", 2) end
      if frame_pins > 10 then
        return error("Roll Error: Pin count over 10", 2)
      end

      -- calculate throw score
      score = score
        + (
          (bonus < Bonus.ROLL_2X and pins)
          or (bonus < Bonus.ROLL_3X and 2 * pins)
          or 3 * pins
        )

      -- adjust bonus
      if bonus == Bonus.ROLL_2X_2X or bonus == Bonus.ROLL_3X_2X then
        if new_bonus == Bonus.NONE then
          bonus = Bonus.ROLL_2X
        elseif new_bonus == Bonus.ROLL_2X_2X then
          bonus = Bonus.ROLL_3X_2X
        else -- new_bonus == Bonus.FILL_ROLL_1X_1X
          bonus = Bonus.FILL_ROLL_2X_1X
        end
      elseif
        bonus == Bonus.FILL_ROLL_1X_1X or bonus == Bonus.FILL_ROLL_2X_1X
      then
        bonus = Bonus.FILL_ROLL_1X
      else
        bonus = new_bonus
      end

      -- cleanup and move to next frame
      if frame_done then
        frame = frame + 1
        new_bonus = Bonus.NONE
        frame_pins = nil
        frame_done = false
      end
    end,
    score = function()
      -- validate can_score
      local can_score = not (
        frame <= 10 or (frame == 11 and bonus > Bonus.NONE)
      )
      if not can_score then
        return error("Roll Error: Game still in progress", 2)
      end

      return score
    end,
  }
end
