globalize_all_functions

string function RTKMutator_FormatFloat( float input, string formatString )
{
	return format( formatString, input )
}

string function RTKMutator_FormatVector( vector input, string formatString )
{
	return format( formatString, format( "<%g, %g, %g>", input.x, input.y, input.z ) )
}

string function RTKMutator_FormatString( string input, string formatString )
{
	return format( formatString, input )
}

string function RTKMutator_ToUpper( string input )
{
	return input.toupper();
}

string function RTKMutator_FormatNumberFloat( float input, int maxIntegers = 3, int maxDecimals = 0 )
{
	return LocalizeAndShortenNumber_Float( input, maxIntegers, maxDecimals )
}

string function RTKMutator_FormatNumberInt( int input, int maxIntegers = 3, int maxDecimals = 0 )
{
	return LocalizeAndShortenNumber_Int( input, maxIntegers, maxDecimals )
}