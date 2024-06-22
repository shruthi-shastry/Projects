library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(plotly)
library(geosphere)
library(shinyalert)

# Load and preprocess the property data
property_data <- read.csv("UpdatedRealEstatefinal1.csv")

# Load and preprocess the crime data
crime_data <- read.csv("Updatedcrimefinal1.csv")

# Load and preprocess the population data
population_data <- read.csv("cleaned_population_final.csv")

school_data <- read.csv("UpdatedSchoolList.csv")

ui <- fluidPage(
  titlePanel("Exploring the Impact of Property Features, Crime Rates, Demographic Changes, and Educational Proximity on Housing Prices in Darwin city, Northern Territory, Australia"),
  
  tabsetPanel(
    tabPanel("About",
             fluidRow(
               column(12,
                      h2(style = "color: #4a8c6f; font-weight: bold;", "Project Overview"),
                      p("Welcome to the Darwin City Property Map, Crime Analysis, and Population Analysis project! This interactive tool is designed to help you explore various aspects of Darwin City, including property prices, crime statistics, population dynamics, and the proximity of properties to schools."),
                      p("As a new user, you can navigate through the different tabs to access a range of visualizations and insights. Each tab focuses on a specific aspect of the city and provides interactive features to help you understand the relationships between different factors."),
                      p("Whether you're a potential homebuyer, real estate professional, urban planner, or researcher, this tool aims to provide valuable information to support your decision-making and analysis."),
                      h3(style = "color: #4a8c6f; font-weight: bold;", "Research Questions"),
                      p("The project aims to address the following key research questions:"),
                      tags$ol(
                        tags$li("How do property characteristics (such as the number of bedrooms, bathrooms, and parking availability) and local crime rates collectively influence housing prices in Darwin City, Northern Territory?"),
                        tags$li("How does the changing population within Darwin City, Northern Territory affect the property values?"),
                        tags$li("How does the proximity to educational institutions affect housing prices in Darwin City, Northern Territory?")
                      ),
                      h3(style = "color: #4a8c6f; font-weight: bold;", "Target Audience"),
                      p("This project is designed to cater to the needs and interests of various stakeholders, including:"),
                      tags$ul(
                        tags$li("Potential homebuyers and investors seeking to understand the factors influencing property prices in Darwin City."),
                        tags$li("Real estate professionals looking to provide data-driven insights and recommendations to their clients."),
                        tags$li("Urban planners and policymakers aiming to make informed decisions regarding urban development, crime prevention, and resource allocation."),
                        tags$li("Researchers and academics interested in studying the relationships between property prices, crime rates, population dynamics, and educational proximity.")
                      ),
                      p("Happy exploring!"),
                      style = "background-color: #f5f5f5; padding: 20px;"
               )
             )
    ),
    
    tabPanel("Property Map",
             fluidRow(
               column(12,
                      h3(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Property Map"),
                      p("The Property Map tab allows you to explore the spatial distribution of properties in Darwin City and their corresponding prices. Here's how you can interact with the map and visualizations:"),
                      tags$ul(
                        tags$li("Use the 'Price Range' slider to filter properties based on your desired price range."),
                        tags$li("Select a specific 'Property Type' using the radio buttons to focus on properties of that type."),
                        tags$li("Click on a property marker on the map to view additional details such as the number of bedrooms, bathrooms, and parking spaces."),
                        tags$li("Hover over the histogram bars to see the exact price range and count of properties in each bin.")
                      ),
                      p("The map and histogram are dynamically linked, so any changes in the filters will update both visualizations accordingly. This allows you to gain insights into the spatial distribution and price ranges of properties in Darwin City."),
                      style = "background-color: #e6f2ff; padding: 20px;"
               ),
               column(4,
                      sliderInput("price_range", "Price Range",
                                  min = min(property_data$price), max = max(property_data$price),
                                  value = c(min(property_data$price), max(property_data$price)))),
               column(8,     radioButtons("property_type", "Property Type",
                                          choices = unique(property_data$property_type),
                                          selected = unique(property_data$property_type)[1])
               )
             ),
             fluidRow(
               
               column(12,    div(style = "text-align: center;",
                                 h4(style = "color: #4a8c6f; font-weight: bold;", "Property Map"),
                                 p("The map displays the geographical distribution of properties in Darwin City. Each circle marker represents a property, with the size of the marker proportional to the price of the property. The color of the markers is based on a color scale that represents the price range. You can interact with the map by zooming in and out, panning, and clicking on markers to view additional details about each property.")
               )
               ),
               
               column(12,
                      div(style = "display: flex; justify-content: center;",
                          leafletOutput("property_map", height = "400px",width = "50%")
                      )
               ),
               fluidRow(
                 column(6,
                        br(),
                        div(style = "text-align: center;",
                            h4(style = "color: #4a8c6f; font-weight: bold;", "Properties with Same Bedrooms and Bathrooms"),
                            p("This table shows the property type, number of properties, and price range for properties with the same number of bedrooms and bathrooms as the property you clicked on the map. Click on a row to view the details of all properties with the selected property type, bedrooms, and bathrooms."),
                            DT::dataTableOutput("property_type_table")
                        )
                 ),
                 column(6,
                        br(),
                        div(style = "text-align: center;",
                            h4(style = "color: #4a8c6f; font-weight: bold;", "Property Details"),
                            p("This table displays the details of all properties with the selected property type, bedrooms, and bathrooms. You can view information such as the address, property type, number of bedrooms, bathrooms, parking spaces, and price."),
                            DT::dataTableOutput("property_details_table")
                        )
                 )
               ),
               column(12,
                      br(),
                      div(style = "text-align: center;",
                          h4(style = "color: #4a8c6f; font-weight: bold;", "Property Price Distribution"),
                          p("The histogram shows the distribution of property prices based on the selected filters. The x-axis represents the price ranges, divided into bins, while the y-axis represents the number of properties falling into each price range. You can hover over the bars to view the exact price range and count of properties. This helps you understand the frequency and distribution of property prices in Darwin City."),
                          plotlyOutput("price_histogram", height = "300px")
                      )
               )
             )
    ),
    
    tabPanel("Crime Analysis",
             fluidRow(
               column(12,
                      h3(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Crime Analysis"),
                      p("The Crime Analysis tab enables you to analyze crime patterns in Darwin City. You can select a specific year and crime categories to visualize the total offenses by month and compare crime metrics across different categories. Here's how you can interact with the visualizations:"),
                      tags$ul(
                        tags$li("Use the 'Select Year' dropdown to choose a specific year for analysis."),
                        tags$li("Select the desired crime categories from the 'Select Crime Categories' checkboxes to focus on specific types of offenses."),
                        tags$li("Hover over the stacked bar chart to view the exact number of offenses for each category and month."),
                        tags$li("Interact with the radar chart by rotating it to compare the total offenses, alcohol involvement percentage, and domestic violence involvement percentage for each selected crime category.")
                      ),
                      p("The area chart displays the temporal trends of selected crime categories over the years, allowing you to observe changes in the number of offenses over time. The stacked bar chart shows the breakdown of offenses by category and month, helping you identify prevalent crime categories. The radar chart provides a comparative view of crime metrics across categories."),
                      style = "background-color: #fff2e6; padding: 20px;"
               )
             ),
             fluidRow(column(12,
                             h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Crime Trends Over Time"),
                             p("The area chart displays the temporal trends of selected crime categories over the years. It allows you to observe how the number of offenses for each category has changed over time. Hover over the chart to view the exact number of offenses for a specific category and year."),
                             div(style = "display: flex; justify-content: center;",
                                 plotlyOutput("area_chart", height = "400px")
                             )
             )),
             fluidRow(
               column(4,
                      selectInput("year", "Select Year:",
                                  choices = unique(crime_data$Year),
                                  selected = unique(crime_data$Year)[1]),
                      checkboxGroupInput("crime_categories", "Select Crime Categories:",
                                         choices = unique(crime_data$Offence.category),
                                         selected = unique(crime_data$Offence.category)[1:5])
               ),
               column(8,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Total Offences by Month and Crime Category"),
                      p("The stacked bar chart shows the breakdown of offenses by category and month. It enables you to identify trends and patterns in crime occurrences over time and determine which crime categories are most prevalent in each month. Hover over the bars to view the exact number of offenses for each category and month."),
                      plotlyOutput("bar_chart", height = "400px")
               )
             ),
             fluidRow(
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Crime Category Comparison"),
                      p("The radar chart compares the percentage of total offenses for each selected crime category. The chart is normalized so that the sum of all categories is 100%. This provides a visual comparison of the relative magnitudes of these categories, allowing you to identify which categories have higher or lower percentages of total offenses. You can rotate the chart to view the percentages from different angles. Hover over the chart to see the exact percentage for each category."),
                      div(style = "display: flex; justify-content: center;",
                          plotlyOutput("radar_chart", height = "400px")
                      )
               
             ),
            
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Crime Type Comparison"),
                      p("When you click on a specific crime category in the radar chart above, this chart will display the breakdown of offense types within that category. The percentages shown represent the proportion of offenses for each type within the selected category. You can hover over the chart to see the exact percentage for each offense type. This allows you to identify the most prevalent types of offenses within the selected crime category. NOTE : please select the dot of the particular category to get details of its offence type :)"),
                      div(style = "display: flex; justify-content: center;",
                          plotlyOutput("bar_chart_types", height = "400px")
                      )
               )
             )
    ),
    tabPanel("Population Analysis",
             fluidRow(
               column(12,
                      h3(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Population Analysis"),
                      p("The Population Analysis tab provides insights into the population dynamics of Darwin City. Here's how you can explore the visualizations:"),
                      tags$ul(
                        tags$li("The heatmap visualizes the population distribution by age group and year, allowing you to identify patterns and trends over time. Darker colors indicate higher population values, while lighter colors represent lower population values."),
                        tags$li("Clicking on a specific cell in the heatmap generates a population pyramid, which breaks down the population by sex for the selected year. The pyramid is divided into two parts, with the male population on the left and the female population on the right. Each bar represents an age group, and the length of the bar indicates the population size for that age group and sex."),
                        tags$li("The pie chart shows the proportion of Aboriginal and Non-Aboriginal population for the selected year, providing insights into the composition of the population based on Aboriginal status.")
                      ),
                      p("By exploring these visualizations, you can gain a comprehensive understanding of the population structure, age distribution, gender composition, and Aboriginal status proportions in Darwin City over time."),
                      style = "background-color: #e6ffe6; padding: 20px;"
               )
             ),
             fluidRow(
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Population Distribution by Age Group and Year"),
                      p("The heatmap uses color intensity to represent the population size for each age group and year combination. Darker colors indicate higher population values, while lighter colors represent lower population values. By examining the heatmap, you can identify age groups with larger or smaller populations and observe how the population structure changes over time."),
                      div(style = "display: flex; justify-content: center;",
                          plotlyOutput("population_heatmap", height = "500px",width = "70%")
                      )
               )
             ),
             fluidRow(
               column(6,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Population Pyramid"),
                      p("The population pyramid displays the distribution of the male and female population across different age groups for a selected year. The pyramid is divided into two parts, with the male population on the left and the female population on the right. Each bar represents an age group, and the length of the bar indicates the population size for that age group and sex."),
                      div(style = "display: flex; justify-content: center;",
                          plotlyOutput("population_pyramid", height = "500px")
                      ),
                      p("Select a cell in the heatmap to view the population pyramid.")
               )
               ,
             
               column(6,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Aboriginal Status Proportion"),
                      p("The pie chart shows the proportion of Aboriginal and Non-Aboriginal population for the selected year. It provides insights into the composition of the population based on Aboriginal status."),
                      div(style = "display: flex; justify-content: center;",
                          plotlyOutput("aboriginal_status_pie", height = "300px",width = "60%")
                      ),
                      p("Select a cell in the heatmap to view the Aboriginal status proportion.")
               )
             )
             
    ),
    tabPanel("School Proximity Analysis",
             fluidRow(
               column(12,
                      h3(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "School Proximity Analysis"),
                      p("The School Proximity Analysis tab explores the relationship between property prices and their proximity to schools in Darwin City. Here's how you can interact with the visualizations:"),
                      tags$ul(
                        tags$li("Use the 'Select School Level' dropdown to choose a specific school level (Primary, Middle, Senior, or a combination) to view the locations of schools on the map."),
                        tags$li("The map displays the locations of schools in Darwin City, with different colors representing different school levels. Selecting a school level from the dropdown menu filters the map to show only schools of that particular level, allowing you to visualize the spatial distribution of schools and identify areas with a higher concentration of educational institutions."),
                        tags$li("The 'Nearby Properties' table displays the details of properties near the selected school level. It includes information such as the property address, bedroom count, bathroom count, parking count, price, and property type. Note that due to data limitations, nearby properties are only shown for the primary school level. If sufficient data is collected, it will be displayed for the remaining school levels."),
                        tags$li("The scatterplot shows the property prices plotted against the distance to the nearest school. Each point on the scatterplot represents a property, with the x-axis indicating the distance to the nearest school and the y-axis representing the property price. The color of the points is determined by the price, with darker colors indicating higher prices. Hovering over individual points reveals details about each property.")
                      ),p("By examining the scatterplot, you can identify any potential correlations between property prices and proximity to schools. If properties closer to schools tend to have higher prices, it may suggest that school proximity is a factor influencing property values in Darwin City."),
                      style = "background-color: #fff9e6; padding: 20px;"
               )
             ),
             fluidRow(
               column(4,
                      selectInput("school_level", "Select School Level:",
                                  choices = c("All", "Primary", "Middle", "Senior", "Middle & Senior", "Primary & Middle & Senior"),
                                  selected = "All")
               )
             ),
             fluidRow(
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "School Locations"),
                      p("The map displays the locations of schools in Darwin City, with different colors representing different school levels. By selecting a school level from the dropdown menu, you can filter the map to show only schools of that particular level. This allows you to visualize the spatial distribution of schools and identify areas with a higher concentration of educational institutions."),
                      leafletOutput("school_level_map", height = "400px")
               )
             ),
             fluidRow(
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Nearby Properties"),
                      p("The table below displays the details of properties near the selected school level. It includes information such as the property address, bedroom count, bathroom count, parking count, price, and property type. NOTE: Due to lack of data, only properties near primary schools are currently shown. If sufficient data is collected, properties near other school levels will be displayed as well."),
                      DT::dataTableOutput("nearby_properties_table")
               )
             ),
             fluidRow(
               column(12,
                      h4(style = "color: #4a8c6f; font-weight: bold; text-align: center;", "Property Prices vs. Distance to Nearest School"),
                      p("The scatterplot shows the property prices plotted against the distance to the nearest school. Each point on the scatterplot represents a property, with the x-axis indicating the distance to the nearest school and the y-axis representing the property price. The color of the points is determined by the price, with darker colors indicating higher prices."),
                      p("By examining the scatterplot, you can identify any potential correlations between property prices and proximity to schools. If properties closer to schools tend to have higher prices, it may suggest that school proximity is a factor influencing property values in Darwin City. Hover over individual points to view details about each property, such as its address, price, number of bedrooms, bathrooms, and parking spaces."),
                      plotlyOutput("school_rating_price_scatter", height = "500px")
               )
             )
    )
  )
)

server <- function(input, output) {
  
  # Welcome popup message
  shinyalert(
    title = "Welcome!",
    text = "Thank you for taking the time to explore this interactive visualization of Darwin City. I hope you find the information and insights valuable. Enjoy your exploration!",
    confirmButtonText = "Get Started",
    showConfirmButton = TRUE,
    timer = 0,
    animation = TRUE
  )
  
  # Filter properties based on price range and property type
  filtered_properties <- reactive({
    property_data %>%
      filter(price >= input$price_range[1] & price <= input$price_range[2],
             property_type == input$property_type)
  })
  # Create the property map
  output$property_map <- renderLeaflet({
    leaflet(filtered_properties()) %>%
      addTiles() %>%
      setView(lng = 130.8410, lat = -12.4634, zoom = 13) %>%
      addCircleMarkers(
        lng = ~longitude,
        lat = ~latitude,
        radius = ~sqrt(price) / 100,
        color = ~colorNumeric(palette = "YlOrRd", domain = price)(price),
        stroke = FALSE,
        layerId = ~address_1,
        fillOpacity = 0.7,
        popup = ~paste0(
          "<strong>Address:</strong> ", address_1, "<br>",
          "<strong>Price:</strong> $", price, "<br>",
          "<strong>Bedrooms:</strong> ", bedroom_count, "<br>",
          "<strong>Bathrooms:</strong> ", bathroom_count, "<br>",
          "<strong>Parking:</strong> ", parking_count
        )
      ) %>%
      addLegend(pal = colorNumeric(palette = "YlOrRd", domain = property_data$price),
                values = ~price,
                title = "Price",
                position = "bottomright")
  })
  
  # Create the property type table
  output$property_type_table <- DT::renderDataTable({
    clicked_property <- input$property_map_marker_click
    
    if (!is.null(clicked_property)) {
      selected_property <- property_data %>% filter(address_1 == clicked_property$id)
      
      if (nrow(selected_property) > 0) {
        selected_bedrooms <- selected_property$bedroom_count
        selected_bathrooms <- selected_property$bathroom_count
        
        property_type_data <- property_data %>%
          filter(bedroom_count == selected_bedrooms, bathroom_count == selected_bathrooms) %>%
          group_by(property_type) %>%
          summarise(
            count = n_distinct(address_1),  # Count distinct addresses
            min_price = min(price),
            max_price = max(price),
            .groups = "drop"
          ) %>%
          mutate(price_range = paste0("$", format(min_price, big.mark = ","), " - $", format(max_price, big.mark = ",")))
        
        DT::datatable(property_type_data[, c("property_type", "count", "price_range")],
                      options = list(pageLength = 5, dom = 't'),
                      colnames = c("Property Type", "Number of Properties", "Price Range"),
                      rownames = FALSE)
      } else {
        DT::datatable(data.frame(Message = "No data available for the clicked property."),
                      options = list(dom = 't'),
                      colnames = NULL,
                      rownames = FALSE)
      }
    } else {
      DT::datatable(data.frame(Message = "Click on a property marker to view the table."),
                    options = list(dom = 't'),
                    colnames = NULL,
                    rownames = FALSE)
    }
  })
            
  
  # Create the property details table
  output$property_details_table <- DT::renderDataTable({
    clicked_property <- input$property_map_marker_click
    clicked_row <- input$property_type_table_rows_selected
    
    if (!is.null(clicked_property) && !is.null(clicked_row)) {
      selected_property <- property_data %>% filter(address_1 == clicked_property$id)
      
      if (nrow(selected_property) > 0) {
        selected_bedrooms <- selected_property$bedroom_count
        selected_bathrooms <- selected_property$bathroom_count
        
        property_type_data <- property_data %>%
          filter(bedroom_count == selected_bedrooms, bathroom_count == selected_bathrooms) %>%
          group_by(property_type) %>%
          summarise(
            count = n(),
            min_price = min(price),
            max_price = max(price),
            .groups = "drop"
          )
        
        selected_property_type <- property_type_data$property_type[clicked_row]
        
        property_details <- property_data %>%
          filter(bedroom_count == selected_bedrooms, bathroom_count == selected_bathrooms, property_type == selected_property_type) %>%
          distinct(address_1, .keep_all = TRUE)
        
        DT::datatable(property_details[, c("address_1", "property_type", "bedroom_count", "bathroom_count", "parking_count", "price")],
                      options = list(pageLength = 5),
                      colnames = c("Address", "Property Type", "Bedrooms", "Bathrooms", "Parking", "Price"),
                      rownames = FALSE)
      } else {
        DT::datatable(data.frame(Message = "No data available for the clicked property."),
                      options = list(dom = 't'),
                      colnames = NULL,
                      rownames = FALSE)
      }
    } else {
      DT::datatable(data.frame(Message = "Click on a property marker and select a row in the property type table to view the details."),
                    options = list(dom = 't'),
                    colnames = NULL,
                    rownames = FALSE)
    }
  })
  
  # Create an interactive histogram of property prices
  output$price_histogram <- renderPlotly({
    ggplot(filtered_properties(), aes(x = price/10000)) +
      geom_histogram(fill = "lightblue", bins = 30) +
      labs(x = "Price (in 10K)", y = "Number of Properties") +
      ggtitle("Distribution of Property Prices") +
      theme_minimal()
  })
  
  # Create the interactive area chart
  output$area_chart <- renderPlotly({
    crime_trends <- crime_data %>%
      filter(Offence.category %in% input$crime_categories) %>%
      group_by(Year, Offence.category) %>%
      summarise(Total_Offences = sum(Number.of.offences), .groups = "drop")
    
    plot_ly(crime_trends, x = ~Year, y = ~Total_Offences, color = ~Offence.category, type = "scatter", mode = "lines", stackgroup = "one",
            text = ~paste0("Year: ", Year, "<br>",
                           "Category: ", Offence.category, "<br>",
                           "Total Offences: ", Total_Offences),
            hoverinfo = "text") %>%
      layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Total Offences"),
        legend = list(title = "Offence Category", orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
        title = list(text = "Crime Trends Over Time")
      )
  })
  
  # Filter crime data based on selected year and categories
  filtered_crime_data <- reactive({
    crime_data %>%
      filter(Year == input$year, Offence.category %in% input$crime_categories)
  })
  
  # Create the interactive bar chart
  output$bar_chart <- renderPlotly({
    crime_summary <- filtered_crime_data() %>%
      group_by(Offence.category, `Month.number`) %>%
      summarise(Total_Offences = sum(Number.of.offences), .groups = "drop")
    
    plot_ly(crime_summary,
            x = ~`Month.number`,
            y = ~Total_Offences,
            color = ~Offence.category,
            type = "bar",
            text = ~paste0("Category: ", Offence.category, "<br>",
                           "Month: ", `Month.number`, "<br>",
                           "Total Offences: ", Total_Offences),
            hoverinfo = "text") %>%
      layout(
        xaxis = list(title = "Month", tickmode = "linear", dtick = 1),
        yaxis = list(title = "Total Offences"),
        legend = list(title = "Offence Category", orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
        title = list(text = "Total Offences by Month and Crime Category"),
        barmode = "stack"
      )
  })
  
  
  
  # Filter crime data based on selected year and categories
  filtered_crime_data <- reactive({
    crime_data %>%
      filter(Year == input$year, Offence.category %in% input$crime_categories)
  })

  
  # Create the initial radar chart
  output$radar_chart <- renderPlotly({
    crime_metrics <- filtered_crime_data() %>%
      group_by(Offence.category) %>%
      summarise(Total_Offences = sum(Number.of.offences), .groups = "drop") %>%
      mutate(Percentage = Total_Offences / sum(Total_Offences) * 100)
    
    p <- plot_ly(
      data = crime_metrics,
      type = "scatterpolar",
      mode = "lines+markers",
      r = ~Percentage,
      theta = ~Offence.category,
      fill = "toself",
      text = ~paste0(
        "Category: ", Offence.category, "<br>",
        "Percentage: ", round(Percentage, 2), "%"
      ),
      hoverinfo = "text",
      line = list(width = 2),
      marker = list(size = 8)
    ) %>%
      layout(
        polar = list(
          radialaxis = list(
            visible = TRUE,
            range = c(0, 100)
          )
        ),
        title = list(text = "Crime Category Comparison", font = list(size = 16)),
        legend = list(
          title = list(text = "Crime Categories"),
          font = list(size = 12),
          orientation = "h",
          y = -0.2
        )
      )
    
    p %>% event_register("plotly_click")
  })
  
  # Create a reactive value to store the clicked category
  clicked_category <- reactiveVal(NULL)
  
  observeEvent(event_data("plotly_click"), {
    event <- event_data("plotly_click")
    
    
    if (!is.null(event)) {
      curve_num <- event$curveNumber
      point_num <- event$pointNumber
      
      crime_metrics <- filtered_crime_data() %>%
        group_by(Offence.category) %>%
        summarise(Total_Offences = sum(Number.of.offences), .groups = "drop") %>%
        mutate(Percentage = Total_Offences / sum(Total_Offences) * 100)
      
      category <- crime_metrics$Offence.category[point_num + 1]  # Adjusting for 1-based indexing in R
      clicked_category(category)
      
    }
  })
  
  output$bar_chart_types <- renderPlotly({
    req(clicked_category())
    
    crime_metrics <- filtered_crime_data() %>%
      filter(Offence.category == clicked_category()) %>%
      group_by(Offence.type) %>%
      summarise(Total_Offences = sum(Number.of.offences), .groups = "drop") %>%
      mutate(Percentage = Total_Offences / sum(Total_Offences) * 100)
    
    plot_ly(
      data = crime_metrics,
      x = ~Offence.type,
      y = ~Percentage,
      type = "bar",
      text = ~paste0(
        "Type: ", Offence.type, "<br>",
        "Percentage: ", round(Percentage, 2), "%"
      ),
      hoverinfo = "text",
      marker = list(color = 'rgba(55, 128, 191, 0.7)',
                    line = list(color = 'rgba(55, 128, 191, 1.0)',
                                width = 2))
    ) %>%
      layout(
        title = list(text = paste("Offense Types for", clicked_category()), font = list(size = 16)),
        xaxis = list(title = "Offense Type"),
        yaxis = list(title = "Percentage"),
        showlegend = FALSE
      )
  })
 
  
 
  #heatmap
  output$population_heatmap <- renderPlotly({
    plot_ly(
      data = population_data,
      x = ~Year,
      y = ~`Age.Group`,
      z = ~Population,
      type = "heatmap",
      colorscale = "YlGnBu",
      hoverinfo = "text",
      text = ~paste(
        "Sex:", Sex,
        "<br>Aboriginal Status:", Aboriginal.status,
        "<br>Population:", Population,
        "<br>Age Group:", `Age.Group`,
        "<br>Year:", Year
      )
    ) %>%
      layout(
        title = "Population Distribution in Darwin by Age Group and Year",
        xaxis = list(title = "Year"),
        yaxis = list(title = "Age Group"),
        colorbar = list(title = "Population")
      ) %>%
      event_register("plotly_click")
  })
  
  # Create the population pyramid
  output$population_pyramid <- renderPlotly({
    clicked_data <- event_data("plotly_click")
    
    if (!is.null(clicked_data)) {
      selected_year <- clicked_data$x
      pyramid_data <- population_data %>%
        filter(Year == selected_year) %>%
        mutate(
          Population = ifelse(Sex == "Male", -Population, Population),
          Age_Group = factor(
            `Age.Group`,
            levels = unique(population_data$`Age.Group`),
            ordered = TRUE
          )
        )
      
      pyramid_plot <- ggplot(pyramid_data, aes(x = Age_Group, y = Population, fill = Sex)) +
        geom_bar(stat = "identity", width = 0.8) +
        coord_flip() +
        scale_y_continuous(labels = abs) +
        labs(
          title = paste("Population Pyramid -", selected_year),
          x = "Age Group",
          y = "Population"
        ) +
        theme_minimal() +
        theme(legend.position = "top") +
        scale_fill_manual(values = c("Male" = "#1f77b4", "Female" = "#90EE90"))  # Matching colors with heatmap
      
      ggplotly(pyramid_plot)
    } else {
      # Display an empty plot when no year is clicked
      plot_ly() %>%
        layout(
          title = "Click on a year in the heatmap to see the population pyramid."
        )
    }
  })
  
  # Create the Aboriginal status pie chart
  output$aboriginal_status_pie <- renderPlotly({
    clicked_data <- event_data("plotly_click")
    
    if (!is.null(clicked_data)) {
      selected_year <- clicked_data$x
      aboriginal_data <- population_data %>%
        filter(Year == selected_year) %>%
        group_by(Aboriginal.status) %>%
        summarise(Population = sum(Population), .groups = "drop")
      
      plot_ly(aboriginal_data, labels = ~Aboriginal.status, values = ~Population, type = "pie",
              textposition = "inside", textinfo = "percent",
              marker = list(colors = c("#2ca02c", "#0000FF")),  # Matching colors with heatmap
              showlegend = TRUE) %>%  # Add legend
        layout(title = list(text = paste("Aboriginal Status Proportion -", selected_year), y = 0.95))
    } else {
      # Display an empty plot when no year is clicked
      plot_ly() %>%
        add_trace(type = "pie", values = c(1), labels = c(""), textinfo = "none", marker = list(colors = "white")) %>%
        layout(title = "Click on a year in the heatmap to see the Aboriginal status proportion.")
    }
  })
  
  # School Rating vs. Property Price Scatterplot
  output$school_rating_price_scatter <- renderPlotly({
    # Calculate the distance from each property to the nearest school
    property_school_distances <- property_data %>%
      rowwise() %>%
      mutate(nearest_school_distance = min(distGeo(c(longitude, latitude), school_data[, c("longitude", "latitude")])) / 1000) %>%
      ungroup()
    
    plot_ly(
      data = property_school_distances,
      x = ~nearest_school_distance,
      y = ~price,
      text = ~paste0(
        "Property type: ",property_type ,"<br>",
        "Address: ", address_1, "<br>",
        "Price: $", price, "<br>",
        "Bedroom: ",bedroom_count,"<br>",
        "Bathroom: ",bathroom_count,"<br>",
        "Parking : ",parking_count,"<br>",
        "Distance to Nearest School: ", round(nearest_school_distance, 2), " km"
      ),
      hoverinfo = "text",
      type = "scatter",
      mode = "markers",
      marker = list(
        size = 10,
        color = ~price,
        colorscale = "Viridis",
        showscale = TRUE
      )
    ) %>%
      layout(
        title = "Property Prices vs. Distance to Nearest School",
        xaxis = list(
          title = "Distance to Nearest School (km)",
          range = c(0, 1.6),
          dtick = 0.2
        ),
        yaxis = list(title = "Property Price ($)"),
        hoverlabel = list(bgcolor = "white", font = list(size = 12))
      )
  })
  
  # School Level Map
  output$school_level_map <- renderLeaflet({
    filtered_schools <- school_data %>%
      filter(`Is.Primary.School` == "Yes" | (`Is.Middle.School`) == "Yes" | (`Is.Senior.School`)== "Yes")
    
    if (input$school_level == "Primary") {
      filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "No" & `Is.Senior.School` == "No")
    } else if (input$school_level == "Middle") {
      filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "No")
    } else if (input$school_level == "Senior") {
      filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "No" & `Is.Senior.School` == "Yes")
    } else if (input$school_level == "Middle & Senior") {
      filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes")
    } else if (input$school_level == "Primary & Middle & Senior") {
      filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes")
    }
    
    colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#9467bd", "#8c564b")
    labels <- c("Primary", "Middle", "Senior", "Middle & Senior", "Primary & Middle & Senior")
    
    leaflet(filtered_schools) %>%
      addTiles() %>%
      setView(lng = 130.8410, lat = -12.4634, zoom = 13) %>%
      addCircleMarkers(
        lng = ~longitude,
        lat = ~latitude,
        radius = 8,
        layerId = ~Name,
        color = ~ifelse(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "No" & `Is.Senior.School` == "No", colors[1],
                        ifelse(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "No", colors[2],
                               ifelse(`Is.Primary.School` == "No" & `Is.Middle.School` == "No" & `Is.Senior.School` == "Yes", colors[3],
                                      ifelse(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes", colors[4],
                                             ifelse(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes", colors[5], "#000000"))))),
        stroke = FALSE,
        fillOpacity = 0.7,
        popup = ~paste0(
          "<strong>School Name:</strong> ", Name, "<br>",
          "<strong>Address:</strong> ", `Physical.Address`, "<br>",
          "<strong>School Level:</strong> ",
          ifelse(`Is.Primary.School` == "Yes", "Primary ", ""),
          ifelse(`Is.Middle.School` == "Yes", "Middle ", ""),
          ifelse(`Is.Senior.School` == "Yes", "Senior ", "")
        )
      ) %>%
      addLegend(title = "School Level",
                colors = colors,
                labels = labels,
                position = "bottomright")
  })
  
  # Nearby Properties Table
  output$nearby_properties_table <- DT::renderDataTable({
    if (input$school_level != "All") {
      filtered_schools <- school_data %>%
        filter(`Is.Primary.School` == "Yes" | (`Is.Middle.School`) == "Yes" | (`Is.Senior.School`)== "Yes")
      
      if (input$school_level == "Primary") {
        filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "No" & `Is.Senior.School` == "No")
      } else if (input$school_level == "Middle") {
        filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "No")
      } else if (input$school_level == "Senior") {
        filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "No" & `Is.Senior.School` == "Yes")
      } else if (input$school_level == "Middle & Senior") {
        filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "No" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes")
      } else if (input$school_level == "Primary & Middle & Senior") {
        filtered_schools <- filtered_schools %>% filter(`Is.Primary.School` == "Yes" & `Is.Middle.School` == "Yes" & `Is.Senior.School` == "Yes")
      }
      
      nearby_properties <- property_data %>%
        rowwise() %>%
        mutate(nearest_school_distance = min(distGeo(c(longitude, latitude), filtered_schools[, c("longitude", "latitude")])) / 1000) %>%
        ungroup() %>%
        filter(nearest_school_distance <= 1) %>%  # Filter properties within 1 km of the selected school level
        distinct()  # Remove duplicate rows
      
      if (nrow(nearby_properties) > 0) {
        DT::datatable(nearby_properties[, c("address_1", "bedroom_count", "bathroom_count", "parking_count", "price", "property_type")],
                      options = list(pageLength = 10),
                      rownames = FALSE)
      } else {
        DT::datatable(data.frame(Message = "No properties found within 1 km of the selected school level."),
                      options = list(searching = FALSE, paging = FALSE, info = FALSE),
                      rownames = FALSE)
      }
    } else {
      DT::datatable(data.frame(Message = "Please select a school level to show the table of properties."),
                    options = list(searching = FALSE, paging = FALSE, info = FALSE),
                    rownames = FALSE)
    }
  })
}

shinyApp(ui, server)