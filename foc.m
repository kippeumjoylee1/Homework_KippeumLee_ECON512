function fval = foc(v,p)
    one = [ 1 0 ];
    two = [ 0 1 ];
    Da = exp( one*( v - p ) )/( 1 + exp( one*( v - p ) ) + exp( two*( v - p ) ) );
    Db = exp( two*( v - p ) )/( 1 + exp( one*( v - p ) ) + exp( two*( v - p ) ) ); 
    fval = [ (Da-(one*p)*Da*(1-Da)) ; (Db-(two*p)*Db*(1-Db)) ];
end