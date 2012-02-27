package com.acminds.acuteauto.persistence.entities;

// Generated Feb 26, 2012 11:32:13 PM by Hibernate Tools 3.4.0.CR1

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToMany;

import com.acminds.acuteauto.persistence.dto.*;

/**
 * Style generated by customhbm2java
 */
@MappedSuperclass
public abstract class AbstractStyle extends
		com.acminds.acuteauto.persistence.BaseDTO implements
		java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Integer styleId;
	private Model model;
	private String name;
	private String description;
	private Integer mpgCity;
	private Integer mpgHighway;
	private int vehicleType;
	private int yearStart;
	private Integer yearEnd;
	private List<Feature> features = new ArrayList<Feature>(0);
	private List<Vehicle> vehicles = new ArrayList<Vehicle>(0);

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "STYLE_ID", unique = true, nullable = false)
	public Integer getStyleId() {
		return this.styleId;
	}

	public void setStyleId(Integer styleId) {
		this.styleId = styleId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODEL_ID", nullable = false)
	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	@Column(name = "NAME", nullable = false, length = 60)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "DESCRIPTION", length = 100)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "MPG_CITY")
	public Integer getMpgCity() {
		return this.mpgCity;
	}

	public void setMpgCity(Integer mpgCity) {
		this.mpgCity = mpgCity;
	}

	@Column(name = "MPG_HIGHWAY")
	public Integer getMpgHighway() {
		return this.mpgHighway;
	}

	public void setMpgHighway(Integer mpgHighway) {
		this.mpgHighway = mpgHighway;
	}

	@Column(name = "VEHICLE_TYPE", nullable = false)
	public int getVehicleType() {
		return this.vehicleType;
	}

	public void setVehicleType(int vehicleType) {
		this.vehicleType = vehicleType;
	}

	@Column(name = "YEAR_START", nullable = false)
	public int getYearStart() {
		return this.yearStart;
	}

	public void setYearStart(int yearStart) {
		this.yearStart = yearStart;
	}

	@Column(name = "YEAR_END")
	public Integer getYearEnd() {
		return this.yearEnd;
	}

	public void setYearEnd(Integer yearEnd) {
		this.yearEnd = yearEnd;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "RL_STYLE_FEATURE", catalog = "carobar", joinColumns = { @JoinColumn(name = "STYLE_ID", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "FEATURE_ID", nullable = false, updatable = false) })
	public List<Feature> getFeatures() {
		return this.features;
	}

	public void setFeatures(List<Feature> features) {
		this.features = features;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "style")
	public List<Vehicle> getVehicles() {
		return this.vehicles;
	}

	public void setVehicles(List<Vehicle> vehicles) {
		this.vehicles = vehicles;
	}

}