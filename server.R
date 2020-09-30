

# server ####
server <- function(input, output, session) {
  
  # Download data
  list_initiators <- as.data.frame(list_initiators)
  edges_for_gephy <- as.data.frame(edges_for_gephy)
  
  # Edges\links   
  links1 <-reactive({
    
    my.list1_new <- edges_for_gephy%>%
      filter(Value >= input$amends_connection) # %in% causes an error 
    
  })
  
  
  
  # Render tables showing content of uploaded files 
  output$table_n <- renderTable({
    links1() # Edges
  })
  
  output$table_l <- renderTable({
    list_initiators #Nodes
  })
  
  output$network_amends <- renderForceNetwork({
    
    
    links1 <- links1()
    
    # These three lines have to solve problem with zero-indexing, but it doesn't work 
    links1$Source <- match(links1$Source, list_initiators$ID_mps)-1 # Працює, але чомусь помилка з"являється 
    links1$Target <- match(links1$Target, list_initiators$ID_mps)-1
    
    
    forceNetwork(Links = links1, # source target   value
                 Nodes = list_initiators, # name
                 Source = "Source",
                 Target = "Target", 
                 Value = "Value",
                 Group = "factions", # Colors
                 NodeID = "names_mps",
                 #linkDistance = networkD3::JS("function(d) { return 2*d.value; }"), # mess with the 5 to mess with the distances
                 Nodesize = "weight_name",
                 opacity = 1, 
                 fontSize = 18, 
                 zoom = T,  
                 #linkDistance = 50,
                 height = "700px", 
                 width = "600px",
                 legend = TRUE,
                 radiusCalculation = JS(" Math.sqrt(d.nodesize)+6"),
                 bounded = TRUE,
                 charge=-20)
    
  })
  
  
}



# Run app ####
shinyApp(ui=ui, server=server)
