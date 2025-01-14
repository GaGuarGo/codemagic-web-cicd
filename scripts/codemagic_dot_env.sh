touch "$CM_BUILD_DIR/.env"
          cat >> "$CM_BUILD_DIR/.env" <<EOF
          PROJECT_ID=$PROJECT_ID
          ORG_ID=$ORG_ID
          ENV=$ENV
          
          