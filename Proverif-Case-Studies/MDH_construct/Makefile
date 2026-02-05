# Makefile for Sigma, IKE, and Simplified IKE using Jaffar's Implementation

ifdef ike
    FOLDER = NDSS_ikeV2_HF_EC
endif

ifdef ike_s
    FOLDER = simplified_ikeV2_HF_EC
endif

ifdef sigma
    FOLDER = sigma_HF_EC
endif

# Logic to point to the Jaffar Implementation sibling directory
ifdef col
    EXT = collision
    # Loaded in order: No_collision (base) then Collision (threat model)
    LIB = -lib hash_no_collision.pvl -lib hash_collision.pvl
else
    EXT = no_collision
    ifdef assoc
        LIB = -lib hash_no_collision.pvl
    else
        LIB = -lib hash_no_collision.pvl
    endif
endif

all:
	proverif $(LIB) -lib isCol.pvl -lib $(FOLDER)/$(FOLDER)_declaration.pvl $(FOLDER)/$(FOLDER)_$(EXT).pv