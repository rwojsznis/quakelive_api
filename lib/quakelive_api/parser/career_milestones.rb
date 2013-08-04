module QuakeliveApi
  module Parser
    class CareerMilestones < Awards
      @selectors = {
        :earned   => ".detailArea",
        :unearned => ".detailArea_off"
      }
    end
  end
end
