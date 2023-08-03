global function ShSpawnSquadSkyDive_Init
global function SpawnGroupSkydive_GetSquadSpawnDelay
global function SpawnGroupSkydive_SetCallback_GetSquadSpawnDelay

#if SERVER
                                                   
                                                                     
                                                                      
                                                          
                                                       
                                                      
                                                           
                                                  
                                          
#endif         

global function SpawnSquadSkyDive_GetRemainingRespawnsForPlayer
global function SpawnSquadSkyDive_GetRemainingRespawnsForAllPlayersInSquad
global function SpawnGroupSkydive_ShouldTeamHavePoolOfRespawns

#if SERVER && DEV
                                                  
#endif                

struct
{
	float functionref( int ) GetSquadSpawnDelay_Callback
	#if SERVER
		                         
		                                                              
		                                                                       
	#endif         
} file

void function ShSpawnSquadSkyDive_Init()
{
	if ( GetRespawnStyle() != eRespawnStyle.SPAWN_GROUP_SKYDIVE )
		return
	print( "Respawn style is SPAWN_GROUP_SKYDIVE\n" )

	#if SERVER
		                                                     

		                                                
		                                                                       

		                                            

		                                                                                   
		                                                                          
	#endif          
}

#if SERVER
                                 
 
	                 
 
#endif          

#if SERVER
                               
 
	                                                                                                       
	                         

	                                                 
	                                                
	                                                  
	                                              
	 
		                
		                                                                              
		                             
		                                
	 

	                              
 
#endif          

#if SERVER
                                                        
 
	                       
 
#endif         

        
                                                               
int function SpawnSquadSkyDive_GetRemainingRespawnsForAllPlayersInSquad( int team )
{
	                                                
	int teamRespawnsCount = GetStartingRespawnCount()
	if ( teamRespawnsCount < 0 )
		return teamRespawnsCount

	                                                         
	teamRespawnsCount = 0
	array < entity > teammates = GetPlayerArrayOfTeam( team )

	foreach ( teammate in teammates )
	{
		teamRespawnsCount += SpawnSquadSkyDive_GetRemainingRespawnsForPlayer( teammate )
	}

	return teamRespawnsCount
}

                                                        
int function SpawnSquadSkyDive_GetRemainingRespawnsForPlayer( entity player )
{
	if ( !IsValid( player ) )
		return 0

	return player.GetPlayerNetInt( "respawnsRemaining" )
}

#if SERVER
                                                                                                                              
                                                                                 
 
	                                              
	                                    
		      

	                         
		      

	                                                                                                     
	                                                              
 
#endif          

#if SERVER
                                                                                                                                                         
                                                                                             
 
	                                              
	                                    
		      

	                                                    
	                                  
	                                                         

	                                 
	 
		                                                                                        

		                                                                                             
		 
			        
		 
		                                                                                                                                                                       
		 
			                                                                                        
			     
		 
		                                                                                                                                               
		 
			                                                                                       
			                                                         
		 
	 
 
#endif          
            

#if SERVER
                                                                              
 
	                                            
 
#endif          

#if SERVER
                                                                 
 
	                           
	                                                                                            
	                                                                                                                                                                                                       

                           
                                                   
                      
       

	                           
	 
		                                                                           
		                                                                                                                                                                                                                                 
			                          
	 
	    
	 
		                                                                             

		                                                                                     
		                                                       
			                                                      
		    
			                                                    

		                                                                                     
		                               
		                                                       
			                                                                       
		    
			                                                                    

		                                                  
		                                                             
		                                                       
			                                                                   

		                         
			                                                
	 
 
#endif          

#if SERVER
                                            
 
		                                                    
		                             
		 
			                                                                          
		 
 
#endif          

#if SERVER && DEV
                                                  
 
	                   

	             
	 
		                                    
		 
			                                                                                                
			                                                                                                              
		 
		      
	 
 
#endif          

#if SERVER
                                                                           
 
	                                                                    
	                                                     

	                                   
	 
		                         
			        

		                                                                       
		                                                  
	 

	                    

	                                                                                                        
	                                                

	                                           
		      

	                                           
	                          
	                                    
	 
		                        
		 
			                     
			     
		 
	 

	                                                           
	                           
		      

	                                                      
	                                    
	 
		                         
			        

		                                                                     
		                                                                

		                                                              
		                                                        
		                                                   

		                                      
		                               
		                                        
		                                                                                                                

		                                       

		                                                                                    
			                                                                                                    

		                                                                       
	 
 
#endif          

#if SERVER
                                                           
 
	                              
	                                    
	                                                       
	                             
	 
		                                                  
		   	                                      
		 
			                         
			                                    
		 
	 

	                                              
	                                             
	                 
		                                               
		 
			                                               
			                                               
			                                              
		 
	 

	                
	                
	                            
	                                                

	                          
	                                      
	                                                                                                         
	                                                                              
	                
 
#endif          

#if SERVER
                                                                                 
 
	                                  
	                                     
	                                                                       
	                                       
	                                         

	                                                           
	                                    

	                                            
	 
		                                                              
		                           
			                                       
	 

	                                          
 
#endif         

#if SERVER
                                                    
 
	                                                             
	                                                                                                            
 
#endif         

#if SERVER
                                                                 
 
	                                                    
	                            
	 
		                                                                                     
			            
	 

	           
 
#endif         

#if SERVER
                                                     
 
	                                        
	                  
	                               
	 
		                                                                               
		 
			                      
			                                
				                      
		 
	 
	                    
 
#endif         

#if SERVER
                                                         
 
	                                                      
 
#endif         

#if SERVER
                                                                
 
	                                        
	                  
	                               
	 
		                                                                               
		 
			                                                                   
			                                    
				                          
		 
	 

	              
 
#endif         

#if SERVER
                                                             
 
	                                                    
	                             
	 
		                                                           
		 
			            
		 
	 

	           
 
#endif         

#if SERVER
                              
 
	                                                                                            
 
#endif         

float function SpawnGroupSkydive_GetSquadSpawnDelay( int team )
{
	float spawnDelay = GetCurrentPlaylistVarFloat( "respawn_cooldown", 5.0 )

	if ( file.GetSquadSpawnDelay_Callback != null )
		spawnDelay = file.GetSquadSpawnDelay_Callback( team )

	return spawnDelay
}

                                                                       
void function SpawnGroupSkydive_SetCallback_GetSquadSpawnDelay( float functionref( int ) func )
{
	Assert( file.GetSquadSpawnDelay_Callback == null )
	file.GetSquadSpawnDelay_Callback = func
}

#if SERVER
                                                                                        
                                                                                                      
 
	                                                          
	                                               
 
#endif         

#if SERVER
                                                                                              
                                                                                                                  
 
	                                                          
	                                               
 
#endif         

                                                                                                                                             
bool function SpawnGroupSkydive_ShouldTeamHavePoolOfRespawns()
{
	return GetCurrentPlaylistVarBool( "spawn_group_skydive_use_team_lives_pool", false )
}
