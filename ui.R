library(shiny)
library(shinydashboard)

# 주요지표 용 tabItem
source("tabItem_keyIndicators.R", encoding = "UTF-8")

dashboardPage(
  title = "Yeungnam University",
  # dashboardHeader(title = "Yeungnam University"),
  # dashboardHeader(title = span("Yeungnam University", style = "background-repeat:no-repeat;background-image:url('http://www.yu.ac.kr/_korean/_image-2017/yu_logo.png')")),
  dashboardHeader(title = tags$a(target = "_blank", href = "http://www.yu.ac.kr", tags$img(src = "img/yu_logo.png"))),
  dashboardSidebar(
    sidebarMenu(id = "sidebarMenu",
                menuItem("주요지표",
                         icon = icon("dashboard"),
                         tabName = "keyIndicators"
                ),
                menuItem("입시",
                         icon = icon("user"),
                         menuSubItem("신입생 선발현황(대학)", tabName = "newStdSltPreconUniv"),
                         menuSubItem("신입생 선발현황(대학원)", tabName = "newStdSltPreconGrsc")
                ),
                menuItem("학생",
                         icon = icon("th"),
                         menuSubItem("학적상태별 현황", tabName = "shregStPrecon"),
                         menuSubItem("장학금 현황", tabName = "scalAmtPrecon")
                ),
                conditionalPanel("input.sidebarMenu == 'keyIndicators'",
                                 hr(),
                                 br(),
                                 p("조회 조건", style = "font-weight:bold"),
                                 numericInput("fromYy", "조회시작연도", min = "2014", max = "2020", value = "2014"),
                                 numericInput("toYy", "조회종료연도", min = "2014", max = "2020", value = "2017"),
                                 # selectInput("univCd", "대학", univChoices),
                                 # selectInput("sustCd", "학과", choices = c("국어국문학과","영어영문학과"))
                                 uiOutput("univSelectOut"),
                                 uiOutput("sustSelectOut"),
                                 
                                 checkboxInput("dashboardRotate", "대학 순환 표시")
                )
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML("
                              .skin-blue .main-header .logo {
                              background-color:#235979;
                              }
                              .skin-blue .main-header .logo:hover {
                              background-color:#235979;
                              }
                              #   .main-header .logo {
                              #     background-repeat:no-repeat;
                              #     background-image:url('img/yu_logo.png');
                              #   }
                              "))),
    tabItems(
      # 주요지표
      tabItem_keyIndicators,
      # 입시
      # 신입생 선발현황(대학)
      tabItem("newStdSltPreconUniv",
              fluidRow(
                box(title = "신입생 지원율(대학)",
                    solidHeader = TRUE,
                    status = "success",
                    collapsible = TRUE,
                    plotOutput("newStdAplyRateUnivPlotOut")
                ),
                box(title = "신입생 최종등록율(대학)",
                    solidHeader = TRUE,
                    status = "info",
                    collapsible = TRUE,
                    plotOutput("newStdFlRegRateUnivPlotOut")
                )
              )
      ),
      # 신입생 선발현황(대학원)
      tabItem("newStdSltPreconGrsc",
              fluidRow(
                box(title = "신입생 지원율(대학원)",
                    solidHeader = TRUE,
                    status = "success",
                    collapsible = TRUE,
                    plotOutput("newStdAplyRateGrscPlotOut")
                ),
                box(title = "신입생 최종등록율(대학원)",
                    solidHeader = TRUE,
                    status = "info",
                    collapsible = TRUE,
                    plotOutput("newStdFlRegRateGrscPlotOut")
                )
              )
      ),
      # 학생
      # 학적상태별 현황
      tabItem("shregStPrecon",
              "학생 - 학적상태별 현황"
      ),
      tabItem("scalAmtPrecon",
              "학생 - 장학생 현황"
      )
    )
  )
)
