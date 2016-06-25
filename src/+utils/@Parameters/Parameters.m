classdef Parameters < handle

   properties
      parameters;
   end
   
   methods(Access=private)
      function newObj = Parameters()
         newObj.parameters = [];
      end
   end
   
   methods(Static)
      function obj = instance()
         persistent uniqueInstance
         if isempty(uniqueInstance)
            obj = utils.Parameters();
            uniqueInstance = obj;
         else
            obj = uniqueInstance;
         end
      end
   end
   
end