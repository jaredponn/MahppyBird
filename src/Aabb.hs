module Aabb ( Aabb (..)
            , hitTest 
            , hitTestAbove
            , hitTestBelow
            , floorAabb
            , ceilingAabb
            ) where

import Linear.V2

data Aabb = Aabb { pMin :: {-# UNPACK #-} !(V2 Float)
                 , pMax :: {-# UNPACK #-} !(V2 Float) }

-- see this page for more on Axis aligned bounding boxes 
{- https://developer.mozilla.org/en-US/docs/Games/Techniques/3D_collision_detection -}
hitTest :: Aabb -> Aabb -> Bool
hitTest (Aabb (V2 xmin0 ymin0) (V2 xmax0 ymax0)) (Aabb (V2 xmin1 ymin1) (V2 xmax1 ymax1)) = 
        (xmin0 <= xmax1 && xmax0 >= xmin1) &&
        (ymin0 <= ymax1 && ymax0 >= ymin1)


{-  hitTestAbove would return true for the following scenario:
    _
   |_| Object
        
   |-----| Line

   returns true because object is above the line
-}
hitTestAbove :: Aabb  -- Object
             -> Aabb -- Line to test if Object is above it. This must have the same y coordinates
             -> Bool
hitTestAbove (Aabb (V2 xmin0 ymin0) (V2 xmax0 ymax0)) (Aabb (V2 xmin1 ymin1) (V2 xmax1 ymax1)) = 
        (xmin0 <= xmax1 && xmax0 >= xmin1) 
        && (ymin0 <= ymin1 || ymax0 <= ymax1 )


{-  hitTestBelow would return true for the following scenario:

   |-----| Line
    _
   |_| Object
        
   returns true because object is above the line
-}
hitTestBelow :: Aabb  -- Object
             -> Aabb -- Line to test if Object is above it. This must have the same y coordinates
             -> Bool
hitTestBelow (Aabb (V2 xmin0 ymin0) (V2 xmax0 ymax0)) (Aabb (V2 xmin1 ymin1) (V2 xmax1 ymax1)) = 
        (xmin0 <= xmax1 && xmax0 >= xmin1) 
        && (ymin0 >= ymin1 || ymax0 >= ymax1 )

{- floorAabb would transform the following Aabb into a line of the lower side: 
    ____         
   |    |        
   |    |  -->   
   |____|        ____
-}
floorAabb :: Aabb -> Aabb
floorAabb (Aabb (V2 xmin ymin) (V2 xmax ymax)) = Aabb (V2 xmin ymax) (V2 xmax ymax)

{- ceilingAabb would transform the following Aabb into a line of the lower side: 
    ____         ____
   |    |        
   |    |  -->   
   |____|       
-}
ceilingAabb :: Aabb -> Aabb
ceilingAabb (Aabb (V2 xmin ymin) (V2 xmax ymax)) = Aabb (V2 xmin ymin) (V2 xmax ymin)
